import Foundation

// Temporary solution to have a mutable data store

/// NOTE: Notice that these classes do not store URL's, instead they store path relative
/// to the `document` folder. But they also offer the URL computed.

class CategoryStorage: Identifiable, Codable {

    public let id: UUID
    public var title: String
    public var imagePath: String?


    // This is the FS symbol associated with every.
    // one like `text.book.closed` can be set by default.
    public var defaultImage: String
}

extension CategoryStorage {

    public var imageURL: URL? {
        if let imagePath {

            do {
                
                let fm = FileManager.default
                let docsURL = try fm.url(for: .documentDirectory,
                                         in: .userDomainMask,
                                         appropriateFor: nil,
                                         create: false)
                guard let formattedPath = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                else { return nil }
                return URL(string: formattedPath, relativeTo: docsURL)
            } catch { return nil }
        } else { return nil }
    }
}

class LectureStorage: Identifiable, Codable {

    public let id: UUID
    public var title: String
    public var categoryId: String?
    public var mediaPath: String?
    public var imagePath: String?
    public var queuePosition: Int?
    public var playPosition: Int?

    public enum State: String, Codable {
        case new
        case managed
        case archived
    }
    public var state: State

    init(id: UUID,
         title: String,
         categoryId: String?,
         mediaPath: String,
         imagePath: String? = nil,
         queuePosition: Int? = nil,
         playPosition: Int? = nil,
         state: State = State.new) {

        self.id = id
        self.title = title
        self.categoryId = categoryId
        self.mediaPath = mediaPath
        self.imagePath = imagePath
        self.queuePosition = queuePosition
        self.playPosition = playPosition
        self.state = state
    }
}

extension LectureStorage {

    public var imageURL: URL? {
        if let imagePath {

            do {

                let fm = FileManager.default
                let docsURL = try fm.url(for: .documentDirectory,
                                         in: .userDomainMask,
                                         appropriateFor: nil,
                                         create: false)
                guard let formattedPath = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                else { return nil }
                return URL(string: formattedPath, relativeTo: docsURL)
            } catch { return nil }
        } else { return nil }
    }

    public var mediaURL: URL? {
        if let mediaPath {

            do {

                let fm = FileManager.default
                let docsURL = try fm.url(for: .documentDirectory,
                                         in: .userDomainMask,
                                         appropriateFor: nil,
                                         create: false)
                guard let formattedPath = mediaPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                else { return nil }
                return URL(string: formattedPath, relativeTo: docsURL)
            } catch { return nil }
        } else { return nil }
    }
}

struct StorageData: Codable {

    var lectures: [LectureStorage]
    var categories: [CategoryStorage]
}

func pathFromAbsoluteURL(url: URL) -> String {

    do {

        let fm = FileManager.default
        let docsURL = try fm.url(for: .documentDirectory,
                                 in: .userDomainMask,
                                 appropriateFor: nil,
                                 create: false)

        var components = url.pathComponents
        var baseComponents = docsURL.pathComponents

        while(!baseComponents.isEmpty && (components[0] == baseComponents[0])) {
            components.removeFirst()
            baseComponents.removeFirst()
        }

        return components.joined(separator: "/")
    } catch { return "" }
}
