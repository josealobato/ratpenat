/// AudioAsset represents an entity that
public struct AudioAsset: Equatable, Identifiable {
    public private(set) var id: Int
    public private(set) var title: String
    public private(set) var subject: Subject

    public init(id: Int,
                title: String,
                subject: Subject) {
        self.id = id
        self.title = title
        self.subject = subject
    }
}
