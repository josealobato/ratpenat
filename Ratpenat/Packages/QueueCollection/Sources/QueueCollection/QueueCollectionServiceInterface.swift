import Foundation
import JToolKit
import struct Entities.Lecture

public protocol QueueCollectionServiceInterface: AutoMockable {

    /// Get the existing lectures.
    func queuedLectures() async throws -> [Lecture]

    /// Remove a given id from the queue.
    /// - Parameter id: the id of the Lecture to dequeue.
    func dequeueLecture(id: String) async throws
}
