import Foundation

final class AudioEngineBuilder: AudioEngineInterfaceBuilder {

    func build(with file: URL,
               onPlaybackRefresh: @escaping (AudioInfo) -> Void,
               onDone: @escaping () -> Void) throws -> AudioEngineInterface {
        
        try AudioEngine(fileURL: file,
                        onPlaybackRefresh: onPlaybackRefresh,
                        onDone: onDone)
    }
}
