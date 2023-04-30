import Foundation
import AVFoundation

class AudioEngine {

    // Files
    private var fileURL: URL

    // AVAudio
    private let audioFile: AVAudioFile
    private let engine = AVAudioEngine()
    private let player = AVAudioPlayerNode()
    private var currentFrame: AVAudioFramePosition {
        guard
            let lastRenderTime = player.lastRenderTime,
            let playerTime = player.playerTime(forNodeTime: lastRenderTime)
        else { return 0 }

        return playerTime.sampleTime
    }
    private var currentPosition: AVAudioFramePosition = 0
    private var audioLengthFrames: AVAudioFramePosition = 0
    private var audioSampleRate: Double = 0
    private var audioLengthSeconds: Double = 0
    // It is a flag to identify that there is a schedule going on and avoid
    // multiple schedules.
    private var needsFileScheduled = true
    // The `seekFrame` is a kind of pointer to the place from the last
    // reschedule frame. It is 0 when the playback is the complete file.
    private var seekFrame: AVAudioFramePosition = 0

    // Display refresh
    private var displayLink: CADisplayLink?
    private var onPlaybackRefresh: ((AudioInfo) -> Void)?

    // MARK: - Initialization

    init(fileURL: URL,
         onPlaybackRefresh: ((AudioInfo) -> Void)? = nil) throws {
        
        self.fileURL = fileURL
        self.onPlaybackRefresh = onPlaybackRefresh
        self.audioFile = try AVAudioFile(forReading: fileURL)
        try self.configureEngine(with: audioFile.processingFormat)
        self.gatherAudioInfo()
        self.setupDisplayLink()
    }

    private func configureEngine(with format: AVAudioFormat) throws {

        self.engine.attach(player)
        self.engine.connect(player,
                            to: engine.mainMixerNode,
                            format: format)
        self.engine.prepare()
        try engine.start()
    }

    private func gatherAudioInfo() {

        audioLengthFrames = audioFile.length
        audioSampleRate = audioFile.processingFormat.sampleRate
        audioLengthSeconds = Double(audioLengthFrames) / audioSampleRate
    }
}

extension AudioEngine {

    private func setupDisplayLink() {
        
        DispatchQueue.main.async {
            self.displayLink = CADisplayLink(target: self,
                                             selector: #selector(self.updateDisplay))
            self.displayLink?.add(to: .current, forMode: .default)
            self.displayLink?.isPaused = true
        }
    }

    @objc private func updateDisplay() {

        currentPosition = currentFrame + seekFrame
        currentPosition = max(currentPosition, 0)
        currentPosition = min(currentPosition, audioLengthFrames)

        if currentPosition >= audioLengthFrames {

            player.stop()
            seekFrame = 0
            currentPosition = 0
            displayLink?.isPaused = true
        }

// Just for debug
//        let playerProgress = Double(currentPosition) / Double(audioLengthFrames)
//        let elapsedTime = Double(currentPosition) / audioSampleRate
//        let remainingTime = audioLengthSeconds - elapsedTime
//        print("jal - Progress (\(playerProgress)) Elapsed (\(elapsedTime)) remaining (\(remainingTime))")

        onPlaybackRefresh?(info())
    }
}

extension AudioEngine: AudioEngineInterface {

    func playToggle() {

        if player.isPlaying {
            player.pause()
            displayLink?.isPaused = true
        } else {
            player.scheduleFile(audioFile, at: nil)
            player.play()
            displayLink?.isPaused = false
        }
    }

    private func scheduleAudioFile() {

        guard needsFileScheduled else { return }

        needsFileScheduled = false
        seekFrame = 0

        player.scheduleFile(audioFile, at: nil) {
            // NOTE: this completion block is executed when the playback ends.
            self.needsFileScheduled = true
        }
    }

    func stop() {

        player.stop()
    }

    func info() -> AudioInfo {

        let format = audioFile.processingFormat
        let audioLengthSamples = audioFile.length
        let audioSampleRate = format.sampleRate
        let audioLengthSeconds = Double(audioLengthSamples) / audioSampleRate

        return AudioInfo(durationInSecons: Int(audioLengthSeconds),
                         isPlaying: player.isPlaying,
                         currentPositionInOnePercent: Double(currentPosition) / Double(audioLengthFrames))
    }

    func seek(to timeInSeconds: Double) {

        // Computing the new current position.
        let offset = AVAudioFramePosition(timeInSeconds * audioSampleRate)
        seekFrame = currentPosition + offset
        seekFrame = max(seekFrame, 0)
        seekFrame = min(seekFrame, audioLengthFrames)
        currentPosition = seekFrame

        // Stopping the playback (will remove the schedule) and remembering the
        // previous state.
        let wasPlaying = player.isPlaying
        player.stop()

        // If the new position is beyond the end, we stop here.
        // Otherwise reschedule the playback.
        if currentPosition < audioLengthFrames {
            //          updateDisplay()
            needsFileScheduled = false

            let frameCount = AVAudioFrameCount(audioLengthFrames - seekFrame)
            player.scheduleSegment(
                audioFile,
                startingFrame: seekFrame,  // Frame to start from
                frameCount: frameCount,    // Number of frames left to the end.
                at: nil
            ) {
                // NOTE: this completion block is executed when the playback ends.
                self.needsFileScheduled = true
            }

            if wasPlaying {
                player.play()
            }
        }
    }
}
