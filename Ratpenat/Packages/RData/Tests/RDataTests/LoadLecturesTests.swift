import XCTest
@testable import RData

final class LoadLecturesTests: XCTestCase {

    var repoUT: LecturesRepository!

    override func setUp() {

        let testStorageURL = Bundle.module.url(forResource: "Fixtures/LecturesTest", withExtension: "json")!
        repoUT = LecturesRepository(storageURL: testStorageURL)
    }

    override func tearDown() {

    }

    func testLoadLecturesFormJSONFile() async throws {

        // GIVEN a repository with a JSON file as storage (on setup).

        // WHEN the lectures are requested.
        let lectures = try await repoUT.lectures()

        // THEN the available lectures are returned (just one tested)
        XCTAssert(lectures.count == 3)
        XCTAssertEqual(lectures[0].id, "01")
        XCTAssertEqual(lectures[0].title, "This is lecture one on English")
        XCTAssertEqual(lectures[0].mediaURL, URL(string: "file://aFolder"))
        XCTAssertNil(lectures[0].imageURL)

        XCTAssertNotNil(lectures[0].category)
        let category = lectures[0].category!
        XCTAssertEqual(category.id, "2")
        XCTAssertEqual(category.title, "Social Science")
        XCTAssertNil(category.imageURL)
        XCTAssertEqual(category.defaultImage, "map")
    }
}
