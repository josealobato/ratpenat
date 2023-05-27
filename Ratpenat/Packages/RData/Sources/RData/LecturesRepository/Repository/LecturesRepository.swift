import Foundation

class LecturesRepository {

    var storage: MutableStorageData

    init(storage: MutableStorageData) {

        self.storage = storage
    }
}

extension LecturesRepository: LecturesRepositoryIntefaceCRUD {

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


extension LecturesRepository: LecturesRepositoryInteface {

//    func lectures() async throws -> [LectureDataEntity] {
//
//        storage?.lecturesDataEntities() ?? []
//    }


    func queuedLectures() async throws -> [LectureDataEntity] {

        []
        // Method to be removed.
//        try await lectures().filter { $0.queued }
    }

    func enqueueLecture(withId id: String) async throws {

//        if let lecture = storage?.lectures.first(where: { $0.id == id }) {
//
//            lecture.queued = true
//        }
    }

    func dequeueLecture(withId id: String) async throws {

//        if let lecture = storage?.lectures.first(where: { $0.id == id }) {
//
//            lecture.queued = false
//        }
    }
}
