import Foundation

extension LecturesRepository: LecturesRepositoryBulkInteface {

    func shallowAdd(lecture: LectureDataEntity) async throws {

        storage.lectures.append(lecture.storedData())
        // We should save here to persist.
    }

    func shallowUpdate(lecture: LectureDataEntity) async throws {

        let storedData = lecture.storedData()

        if let index = storage.lecturesDataEntities().firstIndex(where: { $0.id == storedData.id }) {

            storage.lectures.remove(at: index)
            storage.lectures.insert(storedData, at: index)
        }
        // We should save here to persist.
    }

    func shallowDelete(withId id: String) async throws {

        if let index = storage.lecturesDataEntities().firstIndex(where: { $0.id == id }) {

            storage.lectures.remove(at: index)
        }
        // We should save here to persist.
    }

    func dump() async throws {

    }
}
