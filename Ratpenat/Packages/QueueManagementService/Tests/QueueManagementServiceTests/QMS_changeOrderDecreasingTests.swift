import XCTest
import Entities
import RData
@testable import QueueManagementService

final class QMS_changeOrderDecreasingTests: XCTestCase {

    var qms_ut: QueueManagementService!
    var storageMock: LecturesRepositoryIntefaceCRUDMock!

    override func setUp() async throws {

        storageMock = LecturesRepositoryIntefaceCRUDMock()
    }

    func testChangeOnderIncreasing_QMS0040() async throws {

        // GIVEN a QMS started with some sorted lectures
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage:
        storageMock.lecturesReturnValue = lecturesInOrder
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to sort a lecture to forward position
        await qms_ut.changeOrder(id: "4", from: 4, to: 2)

        // THEN the new possitions should match the request
        let lectures = qms_ut.getQueue()
        let resultingIds = lectures.map { $0.id }
        XCTAssertEqual(resultingIds, ["1", "2", "5", "3", "4", "6"])
    }

    func testChangeOnderIncreasingQueuePosition_QMS0040() async throws {

        // GIVEN a QMS started with some sorted lectures
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage:
        storageMock.lecturesReturnValue = lecturesInOrder
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to sort a lecture to forward position
        await qms_ut.changeOrder(id: "2", from: 4, to: 2)

        // THEN the queue position are adjusted to be the same
        let lectures = qms_ut.getQueue()
        let resultingIds = lectures.map { $0.queuePosition! }
        XCTAssertEqual(resultingIds, [1, 2, 3, 4, 5, 6])
    }

    func testChangeOnderIncreasingStore_QMS0040() async throws {

        // GIVEN a QMS started with some sorted lectures
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage:
        storageMock.lecturesReturnValue = lecturesInOrder
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to sort a lecture to forward position
        await qms_ut.changeOrder(id: "2", from: 4, to: 2)

        // THEN the new order is saved in the store
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.count == 6)
        for dataLecture in storeInvocations {
            XCTAssert(lecturesUpdatedStored.contains(dataLecture))
        }
    }

    private var lecturesInOrder: [LectureDataEntity] {
        [
            LectureDataEntity(id: "1", title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureDataEntity(id: "2", title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            LectureDataEntity(id: "3", title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3),
            LectureDataEntity(id: "4", title: "title 04", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 4),
            LectureDataEntity(id: "5", title: "title 05", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 5),
            LectureDataEntity(id: "6", title: "title 06", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 6)
        ]
    }

    private var lecturesUpdatedStored: [LectureDataEntity] {
        [
            LectureDataEntity(id: "1", title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureDataEntity(id: "2", title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            LectureDataEntity(id: "5", title: "title 05", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3),
            LectureDataEntity(id: "3", title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 4),
            LectureDataEntity(id: "4", title: "title 04", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 5),
            LectureDataEntity(id: "6", title: "title 06", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 6)
        ]
    }
}
