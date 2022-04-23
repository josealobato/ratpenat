/// AudioAsset represents an entity that
public struct AudioAsset: Equatable, Identifiable {
    public private(set) var id: Int
    public private(set) var title: String

    public init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}
