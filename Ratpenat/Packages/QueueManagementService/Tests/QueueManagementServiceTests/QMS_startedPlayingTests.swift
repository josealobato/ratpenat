import XCTest
import Entities
import RData
@testable import QueueManagementService

final class QMS_startedPlayingTests: XCTestCase {

    var qms_ut: QueueManagementService!
    var storageMock: LecturesRepositoryIntefaceCRUDMock!

    override func setUp() async throws {

        storageMock = LecturesRepositoryIntefaceCRUDMock()
    }

    // MARK: - Lesson not in queue

    func testNothinHappenWhenNotInQueue_QMS0080() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLectures
        //       start the service:
        await qms_ut.start()

        // WHEN informing about playing a lecture not in the list
        await qms_ut.startedPlayingLecture(id: uuidString("6"), in: 10)

        // THEN No lecture is playing
        let lectures = qms_ut.getQueue()
        XCTAssertFalse(lectures[0].isPlaying)
        XCTAssertFalse(lectures[1].isPlaying)
    }

    // MARK: - Lesson in queue

    func testPlayingLessonAtTheTopOfTheQueue_QMS0081() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLectures
        //       start the service:
        await qms_ut.start()

        // WHEN informing about playing a lecture at the top of the list
        await qms_ut.startedPlayingLecture(id: uuidString("1"), in: 10)

        // THEN The lecture at the top will start playing...
        let lectures = qms_ut.getQueue()
        XCTAssertTrue(lectures[0].id == uuidString("1"))
        XCTAssertTrue(lectures[0].isPlaying)
        XCTAssertTrue(lectures[1].id == uuidString("2"))
        XCTAssertFalse(lectures[1].isPlaying)
        // ...and persisted the modified lecture
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(lectures[0].dataEntity()))
        // ... but not the rest.
        XCTAssertFalse(storeInvocations.contains(lectures[1].dataEntity()))
    }

    func testPlayingLessonNotAtTheTopOfTheQueue_QMS0081() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLectures
        //       start the service:
        await qms_ut.start()

        // WHEN informing about playing a lecture at is not at the top of the list
        await qms_ut.startedPlayingLecture(id: uuidString("2"), in: 20)

        // THEN The lecture will be move at the top, start playing,...
        let lectures = qms_ut.getQueue()
        XCTAssertTrue(lectures[0].id == uuidString("2"))
        XCTAssertTrue(lectures[0].isPlaying)
        XCTAssertTrue(lectures[0].isPlaying)
        XCTAssertTrue(lectures[1].id == uuidString("1"))
        XCTAssertFalse(lectures[1].isPlaying)
        // ...and persisted all changed lectures (notice the possition in the queue has changed)
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(lectures[0].dataEntity()))
        XCTAssert(storeInvocations.contains(lectures[1].dataEntity()))
    }


    // MARK: - Testing assets

    private var initialLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2)
        ]
    }
}
