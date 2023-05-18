import Foundation
import LectureCollection
import Entities
import RData

class LectureCollectionAdapter: LectureCollectionServiceInterface {

    let repository: LecturesRepositoryInteface

    init(repository: LecturesRepositoryInteface) {

        self.repository = repository
    }

    // MARK: - LectureCollectionServiceInterface

    func lectures() async throws -> [Lecture] {

        try await repository.lectures().map { $0.toLecture()}
    }

    func enqueueLecture(id: String) async throws {

        try await repository.enqueueLecture(withId: id)
    }

    func dequeueLecture(id: String) async throws {

        try await repository.dequeueLecture(withId: id)
    }
}
