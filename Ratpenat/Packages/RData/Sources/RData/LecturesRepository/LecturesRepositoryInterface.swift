import Foundation

public protocol LecturesRepositoryInteface {

    /// The collection of all existing lectures.
    /// - Returns: An Array with all exiting lectures.
    func lectures() async throws -> [LectureDataEntity]

    /// The collection of all queued lectures.
    /// - Returns: An array with all queued lectures.
    func queuedLectures() async throws -> [LectureDataEntity]

    /// Enqueue a lecture with the given id
    /// - Parameter id: the id of the lecture to enqueue.
    func enqueueLecture(withId id: String) async throws

    /// Dequeue a lecture with the given id
    /// - Parameter id: the id of the lecture to dequeue.
    func dequeueLecture(withId id: String) async throws
}
