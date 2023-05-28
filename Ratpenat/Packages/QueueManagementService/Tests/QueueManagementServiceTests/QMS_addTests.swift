import XCTest
import Entities
import RData
@testable import QueueManagementService

final class QMS_addTests: XCTestCase {

    var qms_ut: QueueManagementService!
    var storageMock: LecturesRepositoryIntefaceCRUDMock!

    override func setUp() async throws {

        storageMock = LecturesRepositoryIntefaceCRUDMock()
    }

    // MARK: - Add on top

    func testAddOnTopOfEmptyQueue_QMS0020() async throws {

        // GIVEN a QMS started with an empty queue
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = []
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = addedLecture
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to add alecture on top
        await qms_ut.addToQueueOnTop(id: "9")

        // THEN that will be the single lecture
        let lectures = qms_ut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, ["9"])
        XCTAssertEqual(lectures[0].queuePosition!, 1)
    }

    func testAddOnTopOfQueueWithLectures_QMS0020() async throws {

        // GIVEN a QMS started with an empty queue
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = addedLecture
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to add alecture on top
        await qms_ut.addToQueueOnTop(id: "9")

        // THEN it will be added at possition 1 with queue position 1
        let lectures = qms_ut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, ["9", "1", "2"])
        let resultingPositions = lectures.map { $0.queuePosition }
        XCTAssertEqual(resultingPositions, [1, 2, 3])
    }

    func testAddOnTopOfQueueWithLecturesSavesToStore_QMS0020() async throws {

        // GIVEN a QMS started with an empty queue
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = addedLecture
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to add alecture on top
        await qms_ut.addToQueueOnTop(id: "9")

        // THEN the result will be updated in the store
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.count == 3)
        for dataLecture in storeInvocations {
            XCTAssert(storageUpdatedLecturesWhenAddOnTop.contains(dataLecture))
        }
    }

    // MARK: - Add at bottom

    func testAddAtBottomOfEmptyQueue_QMS0030() async throws {

        // GIVEN a QMS started with an empty queue
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = []
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = addedLecture
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to add alecture at bottom
        await qms_ut.addToQueueAtBottom(id: "9")

        // THEN that will be the single lecture
        let lectures = qms_ut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, ["9"])
        XCTAssertEqual(lectures[0].queuePosition!, 1)
    }

    func testAddAtBottomOfQueueWithLectures_QMS0030() async throws {

        // GIVEN a QMS started with an empty queue
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = addedLecture
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to add alecture at bottom
        await qms_ut.addToQueueAtBottom(id: "9")

        // THEN it will be added at the end
        let lectures = qms_ut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, ["1", "2", "9"])
        let resultingPositions = lectures.map { $0.queuePosition }
        XCTAssertEqual(resultingPositions, [1, 2, 3])
    }

    func testAddAtBottomOfQueueWithLecturesSavesToStore_QMS0030() async throws {

        // GIVEN a QMS started with an empty queue
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = addedLecture
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to add a lecture at bottom
        await qms_ut.addToQueueAtBottom(id: "9")

        // THEN the result will be updated in the store
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.count == 3)
        for dataLecture in storeInvocations {
            XCTAssert(storageUpdatedLecturesWhenAddAtBottom.contains(dataLecture))
        }
    }

    // MARK: - Add existing Object

    func testAddExistingLectureOnTop_QMS0020() async throws {

        // GIVEN a QMS started with an empty queue
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = initialLectures[0]
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to add an existing lecture on top
        await qms_ut.addToQueueOnTop(id: "1")

        // THEN the queue estays the same
        let lectures = qms_ut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, ["1", "2"])
    }

    func testAddExistingLectureAtBottom_QMS0030() async throws {

        // GIVEN a QMS started with an empty queue
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       prepare storage for the lecture to add:
        storageMock.lectureWithIdReturnValue = initialLectures[0]
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to add an existing lecture at bottom.
        await qms_ut.addToQueueAtBottom(id: "1")

        // THEN the queue estays the same
        let lectures = qms_ut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, ["1", "2"])
    }

    // MARK: - Testing assets

    private var initialLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: "1", title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureDataEntity(id: "2", title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2)
        ]
    }

    private var storageUpdatedLecturesWhenAddOnTop: [LectureDataEntity] { // Order not important since it is for update
        [
            LectureDataEntity(id: "9", title: "title 09", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureDataEntity(id: "1", title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            LectureDataEntity(id: "2", title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3)
        ]
    }

    private var storageUpdatedLecturesWhenAddAtBottom: [LectureDataEntity] { // Order not important since it is for update
        [
            LectureDataEntity(id: "9", title: "title 09", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3),
            LectureDataEntity(id: "1", title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureDataEntity(id: "2", title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2)
        ]
    }

    private var addedLecture = LectureDataEntity(id: "9", title: "title 09", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: nil)
}
