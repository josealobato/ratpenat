import Foundation
import AVFoundation

class AudioEngine {

    private var fileURL: URL
    private let audioFile: AVAudioFile

    private let engine = AVAudioEngine()
    private let player = AVAudioPlayerNode()

    init(fileURL: URL) throws {
        self.fileURL = fileURL
        self.audioFile = try AVAudioFile(forReading: fileURL)
        try self.configureEngine(with: audioFile.processingFormat)
    }

    private func configureEngine(with format: AVAudioFormat) throws {

        engine.attach(player)
        engine.prepare()
        try engine.start()
    }
}

extension AudioEngine: AudioEngineInterface {

    func playToggle() {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
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
                         isPlaying: player.isPlaying)
    }
}
