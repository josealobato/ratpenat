import Foundation
import JToolKit

/// CRUD interface to manange `LectureDataEntities`.
public protocol LecturesRepositoryInteface: AutoMockable {

    // Create
    func add(lecture: LectureDataEntity) async throws

    // Read
    func lectures() async throws -> [LectureDataEntity]
    func lecture(withId id: String) async throws -> LectureDataEntity?

    // Update
    func update(lecture: LectureDataEntity) async throws

    // Delete
    func delete(withId id: String) async throws
}
