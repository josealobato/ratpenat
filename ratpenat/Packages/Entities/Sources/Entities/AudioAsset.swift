/// AudioAsset represents an entity that
public struct AudioAsset: Equatable {
    public private(set) var title: String
    public private(set) var location: String

    public init(title: String,
                location: String) {
        self.title = title
        self.location = location
    }
}
