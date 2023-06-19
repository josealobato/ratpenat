import Foundation
import QueueCollection
import Entities
import RData
import QueueManagementService

class QueueCollectionAdapter: QueueCollectionServiceInterface {

    let queueManagement: QueueManagementServiceProtocol

    init(queueManagement: QueueManagementServiceProtocol) {

        self.queueManagement = queueManagement
    }

    // MARK: - LectureCollectionServiceInterface

    func queuedLectures() async throws -> [Lecture] {

        queueManagement.getQueue()
    }

    func dequeueLecture(id: String) async throws {

        await queueManagement.removeFromQueue(id: id)
    }
}
