import Foundation
import JToolKit
import struct Entities.Lecture

public protocol PlayerServiceInterface: AutoMockable {

    /// Get the existing lectures.
    func nextPlay() async throws -> Lecture
}
