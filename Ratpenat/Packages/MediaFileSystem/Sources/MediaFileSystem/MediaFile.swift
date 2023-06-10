import Foundation

/// Media file represent an audio file on the file system.
/// the idea of this type is to "hide" the real full path of the
/// media storage.
public struct MediaFile {

    private(set) public var url: URL

    // With the file name and the ID the real file name will be created (and part of the URL)
    public var id: String? // DB ID.
    public var fileName: String

    /// Internal constructor
    init(url: URL) {
        
        self.url = url
        self.fileName = "bla"  // from URL
    }
}
