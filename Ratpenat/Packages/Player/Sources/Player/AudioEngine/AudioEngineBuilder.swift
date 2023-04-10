import Foundation

final class AudioEngineBuilder: AudioEngineInterfaceBuilder {

    func build(with file: URL) throws -> AudioEngineInterface {

        try AudioEngine(fileURL: file)
    }
}
