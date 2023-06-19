import Foundation
import Player
import Entities
import Foundation
import QueueManagementService

extension Lecture: PlayerLecture { }

class PlayerAdapter: PlayerServiceInterface {

    let queueManagement: QueueManagementServiceProtocol

    init(queueManagement: QueueManagementServiceProtocol) {

        self.queueManagement = queueManagement
    }

    func nextLecture() async throws -> PlayerLecture? {

        queueManagement.getNext()
    }

    func playing(id: String, in second: Int) async {

        await queueManagement.startedPlayingLecture(id: id, in: second)
    }

    func paused(id: String, in second: Int) async {

        await queueManagement.pausedLecture(id: id, in: second)
    }

    func skipped(id: String, in second: Int) async {
        // TODO: why not seconds here?
        await queueManagement.skippedLecture(id: id)
    }

    func donePlaying(id: String) async throws {
        await queueManagement.donePlayingLecture(id: id)
    }
}
