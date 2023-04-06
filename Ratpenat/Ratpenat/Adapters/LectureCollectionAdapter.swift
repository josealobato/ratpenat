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
}
