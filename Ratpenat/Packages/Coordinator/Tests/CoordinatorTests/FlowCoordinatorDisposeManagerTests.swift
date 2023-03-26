import XCTest
@testable import Coordinator

///
/// In this case we are testing that managers are created and disposed properly when
/// their job is done.
///
final class FlowCoordinatorDisposeManagerTests: XCTestCase {

    /// Dev note: In these test we are calling directly "managerCoordination" instead
    /// of the protocol method "coordinate" to avoid async work.

    var coordinatorUnderTest: BaseFlowCoordinator?

    override func setUp() {

        // Given a flow coordinator with two managers.
        let mapping: RequestCoordinatorMappingDictionary = [
            CoordinationRequestName.showTaskDetails: RCMMock1.self,
            CoordinationRequestName.showMessageDetails: RCMMock2.self,
        ]
        coordinatorUnderTest = BaseFlowCoordinator(managersTypeMapping: mapping)
    }

    override func tearDown() { }

    func test_a_single_non_assigned_request() {

        // Given two mapped distinct request are performed on it
        coordinatorUnderTest?.managerCoordination(from: .searchModule, request: .showMessageDetails(messageId: 666, replyId: 111))
        coordinatorUnderTest?.managerCoordination(from: .searchModule, request: .showTaskDetails(taskId: .value("444")))

        // two different managers should be created
        XCTAssertTrue(coordinatorUnderTest?.managers.count == 2)

        // WHEN both managers are done
        let manager1 = coordinatorUnderTest?.managers[0]
        let manager2 = coordinatorUnderTest?.managers[1]
        coordinatorUnderTest?.disposingManager(manager1!)
        coordinatorUnderTest?.disposingManager(manager2!)

        // THEN no manager is left
        XCTAssertTrue(coordinatorUnderTest?.managers.count == 0)
    }
}
