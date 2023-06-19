import Foundation

/// All shallow methods just act on the local data but not on the Storage.
extension LecturesRepository: LecturesRepositoryBulkInteface {

    func shallowAdd(lecture: LectureDataEntity) async throws {

        storageData.lectures.append(lecture.storedData())
    }

    func shallowUpdate(lecture: LectureDataEntity) async throws {

        let storedData = lecture.storedData()

        if let index = storageData.lecturesDataEntities().firstIndex(where: { $0.id == storedData.id }) {

            storageData.lectures.remove(at: index)
            storageData.lectures.insert(storedData, at: index)
        }
    }

    func shallowDelete(withId id: String) async throws {

        if let index = storageData.lecturesDataEntities().firstIndex(where: { $0.id.uuidString == id }) {

            storageData.lectures.remove(at: index)
        }
    }

    func dump() async throws {

        storage.flush(data: storageData)
    }
}
