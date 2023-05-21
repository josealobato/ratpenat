import Foundation
import QueueCollection
import Entities
import RData

class QueueCollectionAdapter: QueueCollectionServiceInterface {

    let repository: LecturesRepositoryInteface

    init(repository: LecturesRepositoryInteface) {

        self.repository = repository
    }

    // MARK: - LectureCollectionServiceInterface

    func queuedLectures() async throws -> [Lecture] {

        try await repository.queuedLectures().map { $0.toLecture()}
    }

    func dequeueLecture(id: String) async throws {

        try await repository.dequeueLecture(withId: id)
    }
}
