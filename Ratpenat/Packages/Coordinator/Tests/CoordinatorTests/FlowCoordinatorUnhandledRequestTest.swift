import XCTest
@testable import Coordinator

///
/// In this case we are testing that coordinator handle nicely attending
/// to request that they are not prepare for. It wont break and they will
/// forward them to the parent coordinator if any
///
final class FlowCoordinatorUnhandledRequestTest: XCTestCase {

    var coordinatorUnderTest: BaseFlowCoordinator?

    override func setUp() {

        // GIVEN a flow coordinator with two managers.
        let mapping: RequestCoordinatorMappingDictionary = [
            CoordinationRequestName.showTaskDetails: RCMMock1.self,
            CoordinationRequestName.showMessageDetails: RCMMock2.self,
        ]
        coordinatorUnderTest = BaseFlowCoordinator(managersTypeMapping: mapping)
    }

    override func tearDown() { }

    func test_unhandled_request() {

        // GIVEN a flow coordinator with some mapping and no parent
        // WHEN a unhandled request is given
        coordinatorUnderTest?.managerCoordination(from: .searchModule, request: .showFileDetails(fileId: .value(666)))

        // THEN nothing manager will be called
        XCTAssertTrue(coordinatorUnderTest?.managers.count == 0)
    }

    func test_unhandled_request_with_parent() {

        // GIVEN a flow coordinator with some mapping and a parent.
        let flowCoordinatorMock = FCMock(requestManagers: [])
        coordinatorUnderTest?.parentCoordinator = flowCoordinatorMock
        
        // WHEN a unhandled request is given.
        coordinatorUnderTest?.managerCoordination(from: .searchModule, request: .showFileDetails(fileId: .value(666)))

        // THEN the request will be passed to the parent.
        XCTAssertTrue(flowCoordinatorMock.coordinateFromRequestCalled == true)
        XCTAssertTrue(flowCoordinatorMock.coordinateFromRequestWithRequest == .showFileDetails(fileId: .value(666)))
    }
}
