import Foundation
import JToolKit
import struct Entities.Lecture

/// These are the errors correctly managed by this module.
/// The rest of thrown errors will be handle as unknown.
public enum LectureDetailsServiceError: Error {

    case invalidID
    case notAbleToSave
    case unkown
}

public protocol LectureDetailsServiceInterface: AutoMockable {

    /// Get the lecture.
    func lecture(withId id: String) async throws -> Lecture

    /// Save the lecture.
    /// - Parameter lecture: lecture to save.
   func save(lecture: Lecture) async throws
}
