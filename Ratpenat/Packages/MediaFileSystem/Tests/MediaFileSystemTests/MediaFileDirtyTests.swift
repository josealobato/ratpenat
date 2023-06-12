import XCTest
@testable import MediaFileSystem

final class MediaFileDirtyTests: XCTestCase {

    // MARK: - New file

    func testUnmodifedNewMediaFile() throws {

        // GIVEN a media file created form a valid URL
        let url = URL(string: "file:///Users/ana.maria/this%20is%20a%20sample%20file%20name.mp3")!
        let mediaFile = MediaFile(url: url, isNew: true)!

        // WHEN The file is not modified.

        // THEN the Media file is not dirty and the file name is unchanged
        XCTAssertFalse(mediaFile.isDirty)
        XCTAssertEqual(mediaFile.fileName, "this is a sample file name.mp3")
    }

    func testModifedNewMediaFile() throws {

        // GIVEN a media file created form a valid URL
        let url = URL(string: "file:///Users/ana.maria/this%20is%20a%20sample%20file%20name.mp3")!
        var mediaFile = MediaFile(url: url, isNew: true)!

        // WHEN The file is not modified.
        mediaFile.id = "33"
        mediaFile.name = "la bamba"

        // THEN the Media file is dirty and the file name is changed
        XCTAssertTrue(mediaFile.isDirty)
        XCTAssertEqual(mediaFile.fileName, "33-la bamba.mp3")
    }
}
