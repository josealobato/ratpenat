import XCTest
import Entities
import RData
@testable import QueueManagementService

final class QMS_pausedTests: XCTestCase {

    var qms_ut: QueueManagementService!
    var storageMock: LecturesRepositoryIntefaceCRUDMock!

    override func setUp() async throws {

        storageMock = LecturesRepositoryIntefaceCRUDMock()
    }

    // MARK: - Lesson not in queue

    func testNothinHappenWhenNotInQueue_QMS0090() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures, where none is playing
        storageMock.lecturesReturnValue = initialLecturesNonePlaying
        //       start the service:
        await qms_ut.start()

        // WHEN informing about pause a lecture not in the list
        await qms_ut.pausedLecture(id: "66", in: 10)

        // THEN No lecture is playing (nothing happen)
        let lectures = qms_ut.getQueue()
        XCTAssertFalse(lectures[0].isPlaying)
        XCTAssertFalse(lectures[1].isPlaying)
    }

    // MARK: - Lesson at the top of queue

    func testPausingLessonAtTheTopOfTheQueueWhenPlaying_QMS0091() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLecturesOnePlaying
        //       start the service:
        await qms_ut.start()

        // WHEN informing about playing a lecture at the top of the list
        await qms_ut.pausedLecture(id: "1", in: 60)

        // THEN The lecture at the top will get a new playPossition
        let lectures = qms_ut.getQueue()
        XCTAssertTrue(lectures[0].isPlaying)
        XCTAssertTrue(lectures[0].playPosition == 60)
        // ...and persisted the modified lecture
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(lectures[0].dataEntity()))
        // ... but not the rest.
        XCTAssertFalse(storeInvocations.contains(lectures[1].dataEntity()))
    }

    func testPausingLessonAtTheTopOfTheQueueWhenNotPlaying_QMS0091() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLecturesNonePlaying
        //       start the service:
        await qms_ut.start()

        // WHEN informing about playing a lecture at the top of the list
        await qms_ut.pausedLecture(id: "1", in: 60)

        // THEN The lecture at the top will get a new playPossition
        let lectures = qms_ut.getQueue()
        XCTAssertTrue(lectures[0].isPlaying)
        XCTAssertTrue(lectures[0].playPosition == 60)
        // ...and persisted the modified lecture
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(lectures[0].dataEntity()))
        // ... but not the rest.
        XCTAssertFalse(storeInvocations.contains(lectures[1].dataEntity()))
    }

    // MARK: - Lesson NOT at the top of queue

    // **NOTE**: In theory this should not happen. When it does we will have a "playing" lesson
    // not at the top of the queue. It will be solved when infoming stated to play again.

    func testPausingLessonNotAtTheTopOfTheQueueWhenPlaying_QMS0091() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLecturesOnePlaying
        //       start the service:
        await qms_ut.start()

        // WHEN informing about playing a lecture at the top of the list
        await qms_ut.pausedLecture(id: "2", in: 60)

        // THEN The lecture at the top will get a new playPossition
        let lectures = qms_ut.getQueue()
        XCTAssertTrue(lectures[1].isPlaying)
        XCTAssertTrue(lectures[1].playPosition == 60)
        // ...and persisted the modified lecture
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(lectures[1].dataEntity()))
        // ... but not the rest.
        XCTAssertFalse(storeInvocations.contains(lectures[0].dataEntity()))
    }

    func testPausingLessonNotAtTheTopOfTheQueueWhenNotPlaying_QMS0091() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures:
        storageMock.lecturesReturnValue = initialLecturesNonePlaying
        //       start the service:
        await qms_ut.start()

        // WHEN informing about playing a lecture at the top of the list
        await qms_ut.pausedLecture(id: "2", in: 60)

        // THEN The lecture at the top will get a new playPossition
        let lectures = qms_ut.getQueue()
        XCTAssertTrue(lectures[1].isPlaying)
        XCTAssertTrue(lectures[1].playPosition == 60)
        // ...and persisted the modified lecture
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(lectures[1].dataEntity()))
        // ... but not the rest.
        XCTAssertFalse(storeInvocations.contains(lectures[0].dataEntity()))
    }

    // MARK: - Testing assets

    private var initialLecturesNonePlaying: [LectureDataEntity] {
        [
            LectureDataEntity(id: "1", title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: nil),
            LectureDataEntity(id: "2", title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2, playPosition: nil)
        ]
    }

    private var initialLecturesOnePlaying: [LectureDataEntity] {
        [
            LectureDataEntity(id: "1", title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: 10),
            LectureDataEntity(id: "2", title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2, playPosition: nil)
        ]
    }
}
