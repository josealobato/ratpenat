import Foundation

struct AudioInfo: Equatable {

    let durationInSecons: Int
    let isPlaying: Bool
    let currentPositionInOnePercent: Double
}

protocol AudioEngineInterfaceBuilder {

    func build(with file: URL,
               onPlaybackRefresh: @escaping (AudioInfo) -> Void) throws -> AudioEngineInterface
}

protocol AudioEngineInterface {

    func playToggle()
    func stop()
    func info() -> AudioInfo
}
