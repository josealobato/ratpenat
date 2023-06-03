import Foundation
import struct Entities.Lecture
import JToolKit

public protocol QueueManagementServiceProtocol: AutoMockable {

    // MARK: - Getting lectures from the queue.

    /// Get the sorted queue.
    /// - Returns: Sorted queue of lectures.
    func getQueue() -> [Lecture]

    /// Get current lecture at the top
    /// - Returns: Current lecture at the top or nil if the queue is empty.
    func getNext() -> Lecture?

    // MARK: - Playing information

    /// Inform the Manager that a lecture started to play.
    ///  - Parameters:
    ///   - id: The id of the lecture
    ///   - second: the play possition in seconds when it started.
    func startedPlayingLecture(id: String, in second: Int)

    /// Inform the Manager that a lecture was paused.
    ///  - Parameters:
    ///   - id: The id of the lecture
    ///   - second: the play possition in seconds when it paused.
    func pausedLecture(id: String, in second: Int)

    //    func skipedLecture(id: String, in second: Int)
//    func donePlayingLecture(id: String)
//
//    // MARK: - Play Request
//    func playLecture(id: String)
//
    // MARK: - Adding and Removing

    /// Add a lecture to the top of the queue (first to next)
    /// - Parameter id: the id of the lecture to add.
    func addToQueueOnTop(id: String)

    /// Add a lecture at the bottom of the queue (last to next)
    /// - Parameter id: the id of the lecture to add.
    func addToQueueAtBottom(id: String)

    /// Remove a lecture from the queue
    /// - Parameter id: the id of the lecture to remove.
    func removeFromQueue(id: String)

    // MARK: - Sorting

    /// Change the position of a Lecture in the Queue
    /// - Parameters:
    ///   - id: Id of the lecture to change
    ///   - origin: Initial Possition.
    ///   - destination: Final Position.
    func changeOrder(id: String, from origin: Int, to destination: Int)
}


