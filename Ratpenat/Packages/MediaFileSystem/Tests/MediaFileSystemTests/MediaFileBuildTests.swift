import XCTest
@testable import MediaFileSystem

final class MediaFileSystemTests: XCTestCase {

    // MARK: - New file

    func testCreateANewFileFromURL() throws {

        // GIVEN a url without hypens
        let url = URL(string: "file:///Users/ana.maria/this%20is%20a%20sample%20file%20name.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url, isNew: true)!

        // THEN the Media file should have nil ID and the rest is name
        XCTAssertNil(mediaFile.id)
        XCTAssertEqual(mediaFile.name, "this is a sample file name")
    }

    func testCreateANewFileFromURLWithHyphens() throws {

        // GIVEN a url without hypens
        let url = URL(string: "file:///Users/ana.maria/this%20is%20a-%20sample%20file-%20name.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url, isNew: true)!

        // THEN the Media file should have nil ID and the rest is name with the hyphens
        XCTAssertNil(mediaFile.id)
        XCTAssertEqual(mediaFile.name, "this is a- sample file- name")
    }

    func testCreateANewFileFromURLWithHyphensAndSpaces() throws {

        // GIVEN a url without hypens
        let url = URL(string: "file:///Users/ana.maria/this%20is%20a-%20sample%20file-%20name%20.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url, isNew: true)!

        // THEN the Media file should have nil ID and the rest is name with the hyphens and not extra spaces.
        XCTAssertNil(mediaFile.id)
        XCTAssertEqual(mediaFile.name, "this is a- sample file- name")
    }

    // MARK: - Not new file

    func testCreateAFileFromURL() throws {

        // GIVEN a url without hypens
        let url = URL(string: "file:///Users/ana.maria/ID123-this%20is%20a%20sample%20file%20name.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url)!

        // THEN the Media file should have ID and the rest is name.
        XCTAssertEqual(mediaFile.id, "ID123")
        XCTAssertEqual(mediaFile.name, "this is a sample file name")
    }

    func testCreateAFileFromURLWithSpaces() throws {

        // GIVEN a url without hypens
        let url = URL(string: "file:///Users/ana.maria/ID123%20-%20this%20is%20a%20sample%20file%20name.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url)!

        // THEN the Media file id should be reveded without the extra spaces.
        XCTAssertEqual(mediaFile.id, "ID123")
        XCTAssertEqual(mediaFile.name, "this is a sample file name")
    }

    func testCreateAFileFromURLWithSpacesAndHyphens() throws {

        // GIVEN a url without hypens
        let url = URL(string: "file:///Users/ana.maria/ID123%20-%20this%20is%20a-%20sample%20file-%20name%20.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url)!

        // THEN the Media file id should be reveded without the extra spaces and hyphens.
        XCTAssertEqual(mediaFile.id, "ID123")
        XCTAssertEqual(mediaFile.name, "this is a- sample file- name")
    }

    // MARK: - Errors

    func testCreateNonNewFileMediaFailsIfDoesNotContainsIdAndName() throws {

        // GIVEN a url with no separation hyphens
        let url = URL(string: "file:///Users/ana.maria/ID123%20%20this%20is%20a%20sample%20file%20name%20.mp3")!

        // WHEN a media file is created from that
        let mediaFile = MediaFile(url: url)

        // THEN it fails
        XCTAssertNil(mediaFile)
    }
}
