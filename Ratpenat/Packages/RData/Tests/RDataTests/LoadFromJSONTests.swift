import XCTest
@testable import RData

/// In this test we just try to test de decoding from a JSON File
final class LoadFromJSONTests: XCTestCase {

    var repo_ut: LecturesRepository!

    override func setUp() {

        repo_ut = LecturesRepository(storage: loadStorage())
    }

    private func loadStorage() -> StorageData {

        // For now we are loading a local file in the package bundle.
        let storageURL = Bundle.module.url(forResource: "Fixtures/LecturesTest", withExtension: "json")!
        do {
            let data = try Data(contentsOf: storageURL)
            let decoder = JSONDecoder()
            return try decoder.decode(StorageData.self, from: data)
        } catch {
            print("Error!! Unable to parse \(storageURL.lastPathComponent)")
            return StorageData(lectures: [], categories: [])
        }
    }

    override func tearDown() {

    }

    func testLoadLecturesFormJSONFile() async throws {

        // GIVEN a repository with a JSON file as storage (on setup).

        // WHEN the lectures are requested.
        let lectures = try await repo_ut.lectures()

        // THEN the available lectures are returned (just one tested)
        XCTAssert(lectures.count == 3)
        XCTAssertEqual(lectures[0].id, "01")
        XCTAssertEqual(lectures[0].title, "This is lecture one on English")
        XCTAssertEqual(lectures[0].mediaURL, URL(string: "file://aFolder"))
        XCTAssertNil(lectures[0].imageURL)
        XCTAssertEqual(lectures[0].state, LectureDataEntity.State.archived)


        XCTAssertNotNil(lectures[0].category)
        let category = lectures[0].category!
        XCTAssertEqual(category.id, "2")
        XCTAssertEqual(category.title, "Social Science")
        XCTAssertNil(category.imageURL)
        XCTAssertEqual(category.defaultImage, "map")
    }
}
