import Foundation
import LectureDetails
import Entities
import RData
import QueueManagementService

class LectureDetailsAdapter: LectureDetailsServiceInterface {

    let repository: LecturesRepositoryInteface

    init(repository: LecturesRepositoryInteface) {

        self.repository = repository
    }

    // MARK: - LectureDetailsServiceInterface

    func lecture(withId id: String) async throws -> Entities.Lecture {

        if let lecture = try await repository.lecture(withId: id)?.toLecture() {
            return lecture
        } else {
            throw LectureDetailsServiceError.invalidID
        }
    }

    func save(lecture: Entities.Lecture) async throws {

        guard let dataLecture = lecture.toDataLecture()
        else { throw LectureDetailsServiceError.notAbleToSave }

        try await repository.update(lecture: dataLecture)
    }
}
