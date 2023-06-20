import XCTest
import Entities
import RData
@testable import QueueManagementService

final class QMS_removeTests: XCTestCase {

    var qms_ut: QueueManagementService!
    var storageMock: LecturesRepositoryIntefaceCRUDMock!

    override func setUp() async throws {

        storageMock = LecturesRepositoryIntefaceCRUDMock()
    }

    // MARK: - Add on top

    func testRemoveFormEmptyQueue_QMS0070() async throws {

        // GIVEN a QMS started with an empty queue
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = []
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to remove a lecture
        await qms_ut.removeFromQueue(id: uuidString("1"))

        // THEN the queue will stay the same
        let lectures = qms_ut.getQueue()
        XCTAssert(lectures.count == 0)
    }

    func testRemoveANonQueuedObject_QMS0070() async throws {

        // GIVEN a QMS started with an empty queue
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to remove a lecture
        await qms_ut.removeFromQueue(id: uuidString("6"))

        // THEN the queue will stay the same
        let lectures = qms_ut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, [uuidString("1"),
                                      uuidString("2"),
                                      uuidString("3")])
        let resultingPositions = lectures.map { $0.queuePosition }
        XCTAssertEqual(resultingPositions, [1, 2, 3])
    }

    func testRemoveAQueuedObject_QMS0070() async throws {

        // GIVEN a QMS started with an empty queue
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to remove a lecture
        await qms_ut.removeFromQueue(id: uuidString("2"))

        // THEN it will remove the requested object
        let lectures = qms_ut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, [uuidString("1"),
                                      uuidString("3")])
        let resultingPositions = lectures.map { $0.queuePosition }
        XCTAssertEqual(resultingPositions, [1, 2])
    }

    func testRemoveAQueuedObjectSavesTheQueueAndTheObjectToStore_QMS0070() async throws {

        // GIVEN a QMS started with an empty queue
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for all lecture:
        storageMock.lecturesReturnValue = initialLectures
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to remove a lecture
        await qms_ut.removeFromQueue(id: uuidString("2"))

        // THEN the resulting queue is saved on store
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.count == 3)
        for dataLecture in storeInvocations {
            XCTAssert(storageUpdatedLecturesWhenRemove.contains(dataLecture))
        }
    }

    // MARK: - Testing assets

    private var initialLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3)
        ]
    }

    private var storageUpdatedLecturesWhenRemove: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: nil),
        ]
    }
}
