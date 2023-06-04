import Foundation

public struct LecturesRepositoryBuilder {

    private static var repo: LecturesRepositoryIntefaceCRUD = LecturesRepository(storage: loadStorage())

    // TODO: notice that this builder is not returning a `LecturesRepositoryBuilder` but a `LecturesRepositoryIntefaceCRUD`
    // and that is not correct.
    public static var shared: LecturesRepositoryIntefaceCRUD { return repo }

    public static func build() -> LecturesRepositoryInteface {

        return LecturesRepository(storage: loadStorage())
    }

    // As a temporal solution we are using a JSON file as storage.
    private static func loadStorage() -> MutableStorageData {

        // For now we are loading a local file in the package bundle.
        let storageURL = Bundle.module.url(forResource: "StorageData", withExtension: "json")!
        do {
            let data = try Data(contentsOf: storageURL)
            let decoder = JSONDecoder()
            return try decoder.decode(MutableStorageData.self, from: data)
        } catch {
            print("Error!! Unable to parse \(storageURL.lastPathComponent)")
            return MutableStorageData(lectures: [], categories: [])
        }
    }
}
