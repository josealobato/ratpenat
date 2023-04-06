import XCTest
@testable import RData


//private class BundleFinder {}
//
//extension Foundation.Bundle {
//    /// Since TeamworkDataTests is a unit tests, the bundle for classes within this module can be used directly.
//    static let module = Bundle(for: BundleFinder.self)
//}


final class LoadLecturesTests: XCTestCase {

    var repoUT: LecturesRepository!

    override func setUp() {

//        let bundle = Bundle.module
//        let thisSourceFile = URL(fileURLWithPath: #file)
//        let thisDirectory = thisSourceFile.deletingLastPathComponent().deletingLastPathComponent()
//        let testStorageURL = thisDirectory.appendingPathComponent("Fixtures/Lectures.json")
//        print(testStorageURL)

        let testStorageURL = Bundle.module.url(forResource: "Fixtures/LecturesTest", withExtension: "json")!
        repoUT = LecturesRepository(storageURL: testStorageURL)
    }

    override func tearDown() {

    }

    func testLoadLecturesFormJSONFile() async throws {

        // GIVEN a repository with a JSON file as storage (on setup).

        // WHEN the lectures are requested.
        let lectures = try await repoUT.lectures()

        // THEN the available lectures are retuned.
        XCTAssert(lectures.count == 2)
        XCTAssertEqual(lectures[0].id, "01")
        XCTAssertEqual(lectures[0].title, "This is lecture one")
        XCTAssertEqual(lectures[0].location, URL(string: "file://aFolder"))
        XCTAssertEqual(lectures[1].id, "02")
        XCTAssertEqual(lectures[1].title, "This is lecture two")
        XCTAssertEqual(lectures[1].location, URL(string: "file://aFolder"))
    }
}
