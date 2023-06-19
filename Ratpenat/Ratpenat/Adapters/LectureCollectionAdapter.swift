import Foundation
import LectureCollection
import Entities
import RData
import QueueManagementService

class LectureCollectionAdapter: LectureCollectionServiceInterface {

    let repository: LecturesRepositoryInteface
    let queueManagement: QueueManagementServiceProtocol

    init(repository: LecturesRepositoryInteface,
         queueManagement: QueueManagementServiceProtocol) {

        self.repository = repository
        self.queueManagement = queueManagement
    }

    // MARK: - LectureCollectionServiceInterface

    func lectures() async throws -> [Lecture] {

        try await repository.lectures().map { $0.toLecture()}
    }

    func enqueueLecture(id: String) async throws {

        await queueManagement.addToQueueAtBottom(id: id)
    }

    func dequeueLecture(id: String) async throws {

        await queueManagement.removeFromQueue(id: id)
    }
}
