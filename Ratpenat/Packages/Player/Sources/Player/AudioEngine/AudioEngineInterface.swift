import Foundation

struct AudioInfo: Equatable {

    let durationInSecons: Int
    let isPlaying: Bool
}

protocol AudioEngineInterfaceBuilder {

    func build(with file: URL) throws -> AudioEngineInterface

}

protocol AudioEngineInterface {

    func playToggle()
    func stop()

    func info() -> AudioInfo
}
