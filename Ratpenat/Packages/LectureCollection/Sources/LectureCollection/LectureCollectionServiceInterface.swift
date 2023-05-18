import Foundation
import JToolKit
import struct Entities.Lecture

public protocol LectureCollectionServiceInterface: AutoMockable {

    /// Get the existing lectures.
    func lectures() async throws -> [Lecture]

    /// Add a given id to the queue.
    /// - Parameter id: the id of the Lecture to enqueue.
    func enqueueLecture(id: String) async throws

    /// Remove a given id from the queue.
    /// - Parameter id: the id of the Lecture to dequeue.
    func dequeueLecture(id: String) async throws
}
