import Foundation

public struct LecturesRepositoryBuilder {

    private static var repo: LecturesRepositoryInteface = LecturesRepository(storage: StorageDataBuilder())

    public static var shared: LecturesRepositoryInteface { return repo }
}
