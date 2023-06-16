import Foundation

extension LecturesRepository: LecturesRepositoryInteface {

    func add(lecture: LectureDataEntity) async throws {

        storageData.lectures.append(lecture.storedData())
        storage.flush(data: storageData)
    }

    func lectures() async throws -> [LectureDataEntity] {

        storageData.lecturesDataEntities()
    }

    func lecture(withId id: String) async throws -> LectureDataEntity? {

        storageData.lecturesDataEntities().first(where: { $0.id == id })
    }

    func update(lecture: LectureDataEntity) async throws {

        let storedData = lecture.storedData()

        if let index = storageData.lecturesDataEntities().firstIndex(where: { $0.id == storedData.id }) {

            storageData.lectures.remove(at: index)
            storageData.lectures.insert(storedData, at: index)
        }
        storage.flush(data: storageData)
    }

    func delete(withId id: String) async throws {

        if let index = storageData.lecturesDataEntities().firstIndex(where: { $0.id == id }) {

            storageData.lectures.remove(at: index)
        }
        storage.flush(data: storageData)
    }
}
