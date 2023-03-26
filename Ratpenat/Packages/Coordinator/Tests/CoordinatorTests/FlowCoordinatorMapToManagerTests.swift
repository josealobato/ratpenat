import XCTest
@testable import Coordinator

///
/// In this case we are testing that manage request are mapped to the correct
/// manager.
///
final class FlowCoordinatorMapToManagerTests: XCTestCase {

    /// Dev note: In these test we are calling directly "managerCoordination" instead
    /// of the protocol method "coordinate" to avoid async work

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

    func test_a_single_non_assigned_request() {

        // WHEN a non mapped request is performed on it
        coordinatorUnderTest?.managerCoordination(from: .searchModule, request: .showFileDetails(fileId: .value(666)))

        // THEN a managers should be created
        XCTAssertTrue(coordinatorUnderTest?.managers.count == 0)
    }

    func test_a_single_request() {

        // WHEN a mapped request is performed on it
        coordinatorUnderTest?.managerCoordination(from: .searchModule, request: .showMessageDetails(messageId: 666, replyId: 111))

        // Them a managers should be createed
        XCTAssertTrue(coordinatorUnderTest?.managers.count == 1)
        let manager = coordinatorUnderTest?.managers[0]
        XCTAssertTrue(manager is RCMMock2)
        if let rcmMock2 = manager as? RCMMock2 {

            // THEN the manager should get the request.
            XCTAssertTrue(rcmMock2.coordinateFromRequestCalled)
            XCTAssertTrue(rcmMock2.coordinateFromRequestWithRequest == .showMessageDetails(messageId: 666, replyId: 111))

            // THEN the manager points back to the flow coordinator
            XCTAssertTrue(rcmMock2.parentCoordinator === coordinatorUnderTest)
        } else { XCTAssert(false) }

    }

    func test_a_double_equal_request() {

        // WHEN two mapped equal request are performed on it
        coordinatorUnderTest?.managerCoordination(from: .searchModule, request: .showMessageDetails(messageId: 666, replyId: 111))
        coordinatorUnderTest?.managerCoordination(from: .searchModule, request: .showMessageDetails(messageId: 777, replyId: 111))

        // THEN two different managers should be created
        XCTAssertTrue(coordinatorUnderTest?.managers.count == 2)
        var manager = coordinatorUnderTest?.managers[0]
        XCTAssertTrue(manager is RCMMock2)
        // THEN there will be a first manager
        if let rcmMock2 = manager as? RCMMock2 {

            // THEN the manager should get the request.
            XCTAssertTrue(rcmMock2.coordinateFromRequestCalled)
            XCTAssertTrue(rcmMock2.coordinateFromRequestWithRequest == .showMessageDetails(messageId: 666, replyId: 111))

            // THEN the manager points back to the flow coordinator
            XCTAssertTrue(rcmMock2.parentCoordinator === coordinatorUnderTest)
        } else { XCTAssert(false) }
        // THEN there will be a second manager
        manager = coordinatorUnderTest?.managers[1]
        XCTAssertTrue(manager is RCMMock2)
        if let rcmMock2 = manager as? RCMMock2 {

            // THEN the manager should get the request.
            XCTAssertTrue(rcmMock2.coordinateFromRequestCalled)
            XCTAssertTrue(rcmMock2.coordinateFromRequestWithRequest == .showMessageDetails(messageId: 777, replyId: 111))

            // THEN the manager points back to the flow coordinator
            XCTAssertTrue(rcmMock2.parentCoordinator === coordinatorUnderTest)
        } else { XCTAssert(false) }
    }

    func test_a_double_different_request() {

        // WHEN two mapped different request are performed on it
        coordinatorUnderTest?.managerCoordination(from: .searchModule, request: .showMessageDetails(messageId: 666, replyId: 111))
        coordinatorUnderTest?.managerCoordination(from: .searchModule, request: .showTaskDetails(taskId: .value("444")))

        // THEN two different managers should be created
        XCTAssertTrue(coordinatorUnderTest?.managers.count == 2)
        var manager = coordinatorUnderTest?.managers[0]
        XCTAssertTrue(manager is RCMMock2)
        // THEN there will be a first manager
        if let rcmMock2 = manager as? RCMMock2 {

            // THEN the manager should get the request.
            XCTAssertTrue(rcmMock2.coordinateFromRequestCalled)
            XCTAssertTrue(rcmMock2.coordinateFromRequestWithRequest == .showMessageDetails(messageId: 666, replyId: 111))

            // THEN the manager points back to the flow coordinator
            XCTAssertTrue(rcmMock2.parentCoordinator === coordinatorUnderTest)
        } else { XCTAssert(false) }
        // THEN there will be a second manager
        manager = coordinatorUnderTest?.managers[1]
        XCTAssertTrue(manager is RCMMock1)
        if let rcmMock1 = manager as? RCMMock1 {

            // THEN the manager should get the request.
            XCTAssertTrue(rcmMock1.coordinateFromRequestCalled)
            XCTAssertTrue(rcmMock1.coordinateFromRequestWithRequest == .showTaskDetails(taskId: .value("444")))

            // THEN the manager points back to the flow coordinator
            XCTAssertTrue(rcmMock1.parentCoordinator === coordinatorUnderTest)
        } else { XCTAssert(false) }
    }
}
