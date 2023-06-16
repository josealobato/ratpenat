import Foundation
import JToolKit

/// CRUD interface to manange `LectureDataEntities` in a bulk fashion.
/// This interface is design to act upon many entities in memory and do not hit
/// the disk until `dump` is requested
public protocol LecturesRepositoryBulkInteface: AutoMockable {

    // Create
    func shallowAdd(lecture: LectureDataEntity) async throws

    // Read
    func lectures() async throws -> [LectureDataEntity]
    func lecture(withId id: String) async throws -> LectureDataEntity?

    // Update
    func shallowUpdate(lecture: LectureDataEntity) async throws

    // Delete
    func shallowDelete(withId id: String) async throws

    func dump() async throws
}
