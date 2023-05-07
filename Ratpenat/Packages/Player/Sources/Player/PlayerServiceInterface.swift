import Foundation
import JToolKit
import struct Entities.Lecture

public protocol PlayerServiceInterface: AutoMockable {

    /// Get the existing lectures if any
    func nextLecture() async throws -> PlayerLecture?
}
