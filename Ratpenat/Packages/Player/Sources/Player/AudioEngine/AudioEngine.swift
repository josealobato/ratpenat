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

        currentPosition = currentFrame
        currentPosition = max(currentPosition, 0)
        currentPosition = min(currentPosition, audioLengthFrames)

        if currentPosition >= audioLengthFrames {

            player.stop()
            currentPosition = 0
            displayLink?.isPaused = true
        }

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
}
