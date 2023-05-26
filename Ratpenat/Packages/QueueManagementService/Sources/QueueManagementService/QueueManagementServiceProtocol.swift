import Foundation
import struct Entities.Lecture

public protocol QueueManagementServiceControlProtocol {

    // MARK: - Getting
    func getQueue() -> [Lecture]
    func getNext() -> Lecture

    // MARK: - Playing
    func startPlayingLecture(id: String, in second: Int)
    func pauseLecture(id: String, in second: Int)
    func skipLecture(id: String, in second: Int)
    func donePlayingLecture(id: String)

    // MARK: - Play Control
    func playLecture(id: String)

    // MARK: - Adding and Removing
    func addToQueueOnTop(id: String)
    func addToQueueAtBottom(id: String)
    func removeFromQueue(id: String)

    // MARK: - Sorting
    func changeOrder(Id: String, from origin: Int, to destinatio: Int)
}


