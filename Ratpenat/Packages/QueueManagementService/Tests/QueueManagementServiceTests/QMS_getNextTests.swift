import XCTest
import Entities
import RData
@testable import QueueManagementService

final class QMS_getNextTests: XCTestCase {

    var qms_ut: QueueManagementService!
    var storageMock: LecturesRepositoryIntefaceCRUDMock!

    override func setUp() async throws {

        storageMock = LecturesRepositoryIntefaceCRUDMock()
    }

    func testGetNextWithNoValuesLecture_QMS0060() async throws {

        // GIVEN a QMS started with no lectures
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage:
        storageMock.lecturesReturnValue = []
        //       start the service:
        await qms_ut.start()

        // WHEN requesting the first lecture
        let lecture = qms_ut.getNext()

        // THEN the lecture at the top will be requested.
        XCTAssertNil(lecture)
    }
    
    func testGetNextWithSomeValuesLecture_QMS0060() async throws {

        // GIVEN a QMS started with some lectures
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage:
        storageMock.lecturesReturnValue = lecturesWithTwoOnList
        //       start the service:
        await qms_ut.start()

        // WHEN requesting the first lecture
        let lecture = qms_ut.getNext()

        // THEN the lecture at the top will be requested.
        XCTAssert(lecture!.id == uuidString("3"))
    }

    // MARK: - Testing assets

    private var lecturesWithTwoOnList: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: nil),
            LectureDataEntity(id: uuid("2"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3),
            LectureDataEntity(id: uuid("3"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1),
            LectureDataEntity(id: uuid("4"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            LectureDataEntity(id: uuid("5"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: nil)
        ]
    }
}
