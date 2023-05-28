import XCTest
import Entities
import RData
@testable import QueueManagementService

final class QMS_AsServiceTests: XCTestCase {

    var qms_ut: QueueManagementService!
    var storageMock: LecturesRepositoryIntefaceCRUDMock!

    override func setUp() async throws {

        storageMock = LecturesRepositoryIntefaceCRUDMock()
        qms_ut = QueueManagementService(storage: storageMock)
    }

    func testStartingAQueue_QMS0010() async throws {

        // GIVEN a QMS and a store with some lectures
        storageMock.lecturesReturnValue = lecturesWithTwoOnList
        // WHEN the QMS service is started
        await qms_ut.start()
        // THEN it will get lectures and build the queue
        let result = qms_ut.getQueue()
        XCTAssert(result.count == 3)
    }

    func testStartingASortedQueue_QMS0010() async throws {

        // GIVEN a QMS and a store with some lectures
        storageMock.lecturesReturnValue = lecturesWithTwoOnList
        // WHEN the QMS service is started
        await qms_ut.start()
        // THEN it will get lectures and build the sorted queue
        let result = qms_ut.getQueue()
        XCTAssert(result[0].id == "3")
        XCTAssert(result[1].id == "4")
        XCTAssert(result[2].id == "2")
    }

    private var lecturesWithTwoOnList: [LectureDataEntity] {
        [
            LectureDataEntity(id: "1", title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: nil),
            LectureDataEntity(id: "2", title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3),
            LectureDataEntity(id: "3", title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureDataEntity(id: "4", title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            LectureDataEntity(id: "5", title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: nil)
        ]
    }
}