import XCTest
import Entities
import RData
@testable import QueueManagementService

final class QMS_skippedTests: XCTestCase {

    var qms_ut: QueueManagementService!
    var storageMock: LecturesRepositoryIntefaceCRUDMock!

    override func setUp() async throws {

        storageMock = LecturesRepositoryIntefaceCRUDMock()
    }

    // MARK: - Lesson not in queue

    func testNothinHappenWhenNotInQueue_QMS0100() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures, where none is playing
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qms_ut.start()

        // WHEN informing about skiping a lecture not in the list
        await qms_ut.skippedLecture(id: "66")

        // THEN nothing happen
        let lectures = qms_ut.getQueue()
        XCTAssertEqual(lectures, initialUnchangedLectures)
    }

    // MARK: - Lesson in queue

    func testSkippingWhenInQueue_QMS0101() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qms_ut.start()

        // WHEN informing about skipped in list
        await qms_ut.skippedLecture(id: uuidString("1"))

        // THEN The lecture is sent to the end and play possition removed.
        let lectures = qms_ut.getQueue()
        XCTAssertEqual(lectures, finalChangedLectures)
        // and the changes stored.
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.count == 3)
        for dataLecture in storeInvocations {
            XCTAssert(finalDataLectures.contains(dataLecture))
        }
    }

    // MARK: - Testing assets

    private var initialDataLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: 10),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3, playPosition: nil)
        ]
    }

    private var initialUnchangedLectures: [Lecture] {
        [
            Lecture(id: uuidString("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: 10),
            Lecture(id: uuidString("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            Lecture(id: uuidString("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3)
        ]
    }

    private var finalChangedLectures: [Lecture] {
        [
            Lecture(id: uuidString("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            Lecture(id: uuidString("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            Lecture(id: uuidString("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3, playPosition: nil),
        ]
    }

    private var finalDataLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2, playPosition: nil),
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3, playPosition: nil)
        ]
    }
}
