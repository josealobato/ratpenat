import Foundation

final class AudioEngineBuilder: AudioEngineInterfaceBuilder {

    func build(with file: URL,
               onPlaybackRefresh: @escaping (AudioInfo) -> Void) throws -> AudioEngineInterface {
        
        try AudioEngine(fileURL: file,
                        onPlaybackRefresh: onPlaybackRefresh)
        
    }
}
