import Foundation

struct AudioInfo: Equatable {

    let durationInSecons: Int
    let isPlaying: Bool
    let currentPositionInOnePercent: Double
    var currentPositionInSeconds: Int {
        Int(Double(durationInSecons) * currentPositionInOnePercent)
    }
}

protocol AudioEngineInterfaceBuilder {

    func build(with file: URL,
               onPlaybackRefresh: @escaping (AudioInfo) -> Void,
               onDone: @escaping () -> Void) throws -> AudioEngineInterface
}

protocol AudioEngineInterface {

    func playToggle()
    func stop()
    func info() -> AudioInfo
    func seek(to timeInSeconds: Double)
}
