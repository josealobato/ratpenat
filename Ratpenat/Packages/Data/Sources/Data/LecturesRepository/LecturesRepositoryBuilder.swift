import Foundation

public struct LecturesRepositoryBuilder {

    public static func build() -> LecturesRepositoryInteface {

        let localStorage = Bundle().url(forResource: "Storage", withExtension: "json")!
        return LecturesRepository(storageURL: localStorage)
    }
}
