import XCTest
@testable import Coordinator

/// In this test case we test that:
/// * A service that is also a Context Provider will be used by
/// the coordinator as context provider.
///
/// **Rationale:** When the coordinator is initialized a bunch of services
/// are passed on creation. When one of those services is a context provider
/// the coordinator will use it as such.
final class FlowCoordinatorContextServiceProviderTest: XCTestCase {

    var coordinatorUnderTest: BaseFlowCoordinator?

    override func setUp() { }

    override func tearDown() { }

    // MARK: - No services

    func test_no_context_provider_service_is_giving_at_initialization() {

        // GIVEN a Coordinator with several services none being a context provider service
        let service1 = CoordinatorServiceProtocolMock()
        let service2 = CoordinatorServiceProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service1, service2])

        // WHEN starting the Coordination
        coordinatorUnderTest?.start()

        // THEN no context provider is set up.
        XCTAssertNil(coordinatorUnderTest?.contextProvider)
    }

    func test_a_context_provider() {

        // GIVEN a Coordinator with several services one being a context provider service
        let service1 = CoordinatorServiceProtocolMock()
        let service2 = ContextProviderServiceProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service1, service2])
        service2.contextReturnValue = ContextMock()

        // WHEN starting the Coordination
        coordinatorUnderTest?.start()

        // THEN the context provider is set up
        XCTAssertNotNil(coordinatorUnderTest!.contextProvider)
    }
}
