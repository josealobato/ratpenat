import Foundation

extension LecturesRepository: LecturesRepositoryInteface {

    func add(lecture: LectureDataEntity) async throws {

        storage.lectures.append(lecture.storedData())
        // We should save here to persist.
    }

    func lectures() async throws -> [LectureDataEntity] {

        storage.lecturesDataEntities()
    }

    func lecture(withId id: String) async throws -> LectureDataEntity? {

        storage.lecturesDataEntities().first(where: { $0.id == id })
    }

    func update(lecture: LectureDataEntity) async throws {

        let storedData = lecture.storedData()

        if let index = storage.lecturesDataEntities().firstIndex(where: { $0.id == storedData.id }) {

            storage.lectures.remove(at: index)
            storage.lectures.insert(storedData, at: index)
        }
        // We should save here to persist.
    }

    func delete(withId id: String) async throws {

        if let index = storage.lecturesDataEntities().firstIndex(where: { $0.id == id }) {

            storage.lectures.remove(at: index)
        }
        // We should save here to persist.
    }
}
