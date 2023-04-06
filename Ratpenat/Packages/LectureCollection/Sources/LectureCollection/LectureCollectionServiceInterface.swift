import Foundation
import JToolKit
import struct Entities.Lecture

public protocol LectureCollectionServiceInterface: AutoMockable {

    /// Get the existing lectures.
    func lectures() async throws -> [Lecture]
}
