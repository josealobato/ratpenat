import Foundation

class LecturesRepository {

    let storageURL: URL
    var storage: StorageData?

    init(storageURL: URL) {

        self.storageURL = storageURL

        loadStorageToMemory()
    }

    func loadStorageToMemory() {

        do {
            let data = try Data(contentsOf: storageURL)
            let decoder = JSONDecoder()
            storage = try decoder.decode(StorageData.self, from: data)
        } catch {
            print("Error!! Unable to parse \(storageURL.lastPathComponent)")
        }
    }
}

extension LecturesRepository: LecturesRepositoryInteface {

    func lectures() async throws -> [LectureDataEntity] {
        
        storage?.lecturesDataEntities() ?? []
    }
}
