//import XCTest
//@testable import RData
//
//// This is a minimal test for the CRUM methods.
//// Notice that this will change when deciding on the right approach on data.
//final class LecturesCRUDTest: XCTestCase {
//
//    var repo_ut: LecturesRepository!
//
//    override func setUp() {
//
//        repo_ut = LecturesRepository(storage: loadStorage())
//    }
//
//    private func loadStorage() -> StorageData {
//
//        // For now we are loading a local file in the package bundle.
//        let storageURL = Bundle.module.url(forResource: "Fixtures/LecturesTest", withExtension: "json")!
//        do {
//            let data = try Data(contentsOf: storageURL)
//            let decoder = JSONDecoder()
//            return try decoder.decode(StorageData.self, from: data)
//        } catch {
//            print("Error!! Unable to parse \(storageURL.lastPathComponent)")
//            return StorageData(lectures: [], categories: [])
//        }
//    }
//
//    func testReadAllLectures() async throws {
//        // GIVEN some lectures
//        // WHEN requesting to get all lectures
//        let result = try? await repo_ut.lectures()
//        // THEN all lectures should be available
//        XCTAssert(result? .count == 3)
//    }
//
//    func testReadOneLecture() async throws {
//        // GIVEN some lectures
//        // WHEN requesting to get one lecture
//        let result = try? await repo_ut.lecture(withId: "01")
//        // THEN that lecture should be available
//        XCTAssertNotNil(result)
//    }
//
//    func testAddLecture() async throws {
//        // GIVEN a new lecture
//        let newLecture = LectureDataEntity(id: "23",
//                                           title: "a lecture",
//                                           mediaURL: URL(string: "https://media")!)
//
//        // WHEN requesting to add that new lecture
//        try! await repo_ut.add(lecture: newLecture)
//
//        // THEN that lecture should be added
//        let result = try? await repo_ut.lectures()
//        XCTAssert(result?.count == 4)
//    }
//
//    func testRemoveLecture() async throws {
//        // GIVEN some lectures
//        // WHEN requesting to remove a lecture
//        try! await repo_ut.delete(withId: "01")
//
//        // THEN that lecture should not be available
//        let result = try? await repo_ut.lectures()
//        XCTAssert(result?.count == 2)
//    }
//
//    func testUpdateLecture() async throws {
//        // GIVEN a new lecture
//        var lecture = try! await repo_ut.lecture(withId: "01")
//        lecture?.title = "A new title"
//
//        // WHEN requesting to update that lecture
//        try! await repo_ut.update(lecture: lecture!)
//
//        // THEN when getting that lecture back, the title should be updated
//        var updatedLecture = try! await repo_ut.lecture(withId: "01")
//        XCTAssertEqual(updatedLecture!.title, "A new title")
//        // and no other lecture has been added
//        let result = try? await repo_ut.lectures()
//        XCTAssert(result?.count == 3)
//    }
//}
