import XCTest
@testable import QueueManagementService

final class QueueManagementServiceTests: XCTestCase {

    var qms_ut: QueueManagementService!
    var storageMock: LecturesRepositoryIntefaceCRUDMock!

    override func setUp() async throws {

        storageMock = LecturesRepositoryIntefaceCRUDMock()
        qms_ut = QueueManagementService(storage: storageMock)
    }
    
    func testExample() throws {

        let result = qms_ut.getQueue()
        XCTAssert(result.isEmpty)
    }
}
