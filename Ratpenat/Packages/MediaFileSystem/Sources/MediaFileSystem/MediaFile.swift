import Foundation

/// Media file represent an audio file on the file system.
/// Through this file the MFS controls the position of the file in the file system
/// while giving external access to the URL for playback.
public struct MediaFile {

    public let url: URL

    public var id: String? {
        didSet { isDirty = true }
    }
    public var name: String {
        didSet { isDirty = true }
    }

    // A media type can be managed only if all needed data is in place.
    public var canBeManaged: Bool { !((id?.isEmpty ?? true) || name.isEmpty) }

    // Dirty will be set to true when any of the properties of the
    // MediaFile has been altered.
    var isDirty: Bool

    /// Is new means that the file was found in the inbox and it will
    /// treated as a new file so the id will be nil and the name will
    /// be the full file name.
    let isNew: Bool

    /// Internal constructor.
    /// Only the MediaFileSystem can create MediaFiles.
    /// Internal constructor.
    /// - Parameters:
    ///   - url: The File URL.
    ///   - isNew: When the file is not yet managed it has not been renamed with `id` and `name`, then
    ///   it is considered new. that means that the `id` will be nil and the reset of the file name will
    ///   be the name.
    init?(url: URL,
          isNew: Bool = false) {
        
        self.url = url
        self.isNew = isNew

        // set the values of id and name
        do {
            self.id = try MediaFile.idFromURL(url: url, isNew: isNew)
            self.name = try MediaFile.nameFromURL(url: url, isNew: isNew)
        } catch { return nil }

        self.isDirty = false
    }

    // MARK: - Getting the name and id from the URL.

    static let allowedExtensions = ["mp3", "mp4"]

    enum Error: Swift.Error {
        case unsupportedMediaFile
        case invalidFileURL
    }

    static func idFromURL(url: URL, isNew: Bool = false) throws -> String? {

        if isNew {
            return nil
        } else {

            let fullFileName = url.lastPathComponent
            let components = fullFileName.split(separator: "-")
            guard components.count >= 2 else { throw Error.invalidFileURL }
            let id = String(components[0])
            return id.trimmingCharacters(in: NSCharacterSet.whitespaces)
        }
    }

    static func nameFromURL(url: URL, isNew: Bool = false) throws -> String {

        let ext = url.pathExtension
        guard allowedExtensions.contains(ext) else { throw Error.unsupportedMediaFile }

        let fullFileName = url.lastPathComponent
        let fileName = fullFileName.dropLast(4)
        if isNew {
            
            let newName = String(fileName)
            return newName.trimmingCharacters(in: NSCharacterSet.whitespaces)
        } else {

            let components = fileName.split(separator: "-")
            let nameComponents = components[1...]
            let newName = nameComponents.joined(separator: "-")
            return newName.trimmingCharacters(in: NSCharacterSet.whitespaces)
        }
    }

    // MARK: - Getting the file name from name and id

    /// Get the name to use on create or update a file.
    var fileName: String {

        if let id {
            return id + "-" + name + "." + url.pathExtension
        } else {
            return name + "." + url.pathExtension
        }
    }
}

extension MediaFile: CustomStringConvertible {

    public var description: String {
"""
    MediaFile: id: \(id ?? "nil"), name: \(name), isDirty: \(isDirty), isNew: \(isNew)
               url: \(url)
"""
    }
}
