import Foundation

class LecturesRepository {

    let storageURL: URL
    var storage: MutableStorageData?

    init(storageURL: URL) {

        self.storageURL = storageURL

        loadStorageToMemory()
    }

    func loadStorageToMemory() {

        do {
            let data = try Data(contentsOf: storageURL)
            let decoder = JSONDecoder()
            storage = try decoder.decode(MutableStorageData.self, from: data)
        } catch {
            print("Error!! Unable to parse \(storageURL.lastPathComponent)")
        }
    }
}

extension LecturesRepository: LecturesRepositoryInteface {

    func lectures() async throws -> [LectureDataEntity] {
        
        storage?.lecturesDataEntities() ?? []
    }

    func enqueueLecture(withId id: String) async throws {

        if let lecture = storage?.lectures.first(where: { $0.id == id }) {

            lecture.queued = true
        }
    }

    func dequeueLecture(withId id: String) async throws {

        if let lecture = storage?.lectures.first(where: { $0.id == id }) {

            lecture.queued = false
        }
    }
}
