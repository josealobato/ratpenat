import Foundation

/// Representation of a lecture.
public struct LectureDataEntity: Identifiable, Codable {

    public let id: String
    public let title: String
    public let location: URL
}
