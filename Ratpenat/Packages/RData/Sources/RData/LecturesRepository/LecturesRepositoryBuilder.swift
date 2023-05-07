import Foundation

public struct LecturesRepositoryBuilder {

    public static func build() -> LecturesRepositoryInteface {

        // For now we are loading a local file in the package bundle.
        let localStorage = Bundle.module.url(forResource: "StorageData", withExtension: "json")!
        return LecturesRepository(storageURL: localStorage)
    }
}
