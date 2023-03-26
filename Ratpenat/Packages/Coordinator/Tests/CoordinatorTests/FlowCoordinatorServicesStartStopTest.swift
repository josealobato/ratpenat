import XCTest
@testable import Coordinator

///
/// In this case we are testing the starting and stoping of services in a
/// Coordinator.
///
final class FlowCoordinatorServicesStartStopTest: XCTestCase {

    var coordinatorUnderTest: BaseFlowCoordinator?

    override func setUp() { }

    override func tearDown() { }

    // MARK: - No services

    func test_start_without_services() {
        // GIVEN a Coordinator with no services
        coordinatorUnderTest = BaseFlowCoordinator()

        // WHEN Starting the Coordination
        coordinatorUnderTest?.start()

        // THEN no service is up and running.
        XCTAssert(coordinatorUnderTest?.services.count == 0)
    }

    func test_stop_without_services() {
        // GIVEN a started Coordinator with no services
        coordinatorUnderTest = BaseFlowCoordinator()
        coordinatorUnderTest?.start()

        // WHEN stoping the Coordination
        coordinatorUnderTest?.stop()

        // THEN no services is up and running.
        XCTAssert(coordinatorUnderTest?.services.count == 0)
    }

    // MARK: - with one basic service

    func test_start_with_one_services() {
        // GIVEN a Coordinator with one service
        let service = CoordinatorServiceProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service])

        // WHEN starting the Coordination
        coordinatorUnderTest?.start()

        // THEN one service is up and running.
        XCTAssert(coordinatorUnderTest?.services.count == 1)
        XCTAssert(coordinatorUnderTest?.services[0] === service)
        XCTAssert(service.startCalled)
        XCTAssert(!service.stopCalled)
    }

    func test_start_with_one_services_linked_to_Coordinator() {
        // GIVEN a Coordinator with one service
        let service = CoordinatorServiceProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service])

        // WHEN starting the Coordination
        coordinatorUnderTest?.start()

        // THEN services reffers to the coordinator.
        XCTAssert(service.coordinator === coordinatorUnderTest!)
    }

    func test_stop_with_one_services() {
        // GIVEN a started coordinator with one service
        let service = CoordinatorServiceProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service])
        coordinatorUnderTest?.start()

        // WHEN stopping the Coordination
        coordinatorUnderTest?.stop()

        // THEN the service is stopped
        XCTAssert(service.startCalled)
        XCTAssert(service.stopCalled)
    }

    // MARK: - with one serveral services

    func test_start_with_serveral_services() {
        // GIVEN a Coordinator with several services
        let service1 = CoordinatorServiceProtocolMock()
        let service2 = CoordinatorServiceProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service1, service2])

        // WHEN Starting the Coordination
        coordinatorUnderTest?.start()

        // THEN services are up and running.
        XCTAssert(coordinatorUnderTest?.services.count == 2)
        XCTAssert(coordinatorUnderTest?.services[0] === service1)
        XCTAssert(service1.startCalled)
        XCTAssert(!service1.stopCalled)
        XCTAssert(coordinatorUnderTest?.services[1] === service2)
        XCTAssert(service2.startCalled)
        XCTAssert(!service2.stopCalled)
    }

    func test_start_with_serveral_services_linked_to_Coordinator() {
        // GIVEN a coordinator with serveral services
        let service1 = CoordinatorServiceProtocolMock()
        let service2 = CoordinatorServiceProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service1, service2])

        // WHEN starting the coordination
        coordinatorUnderTest?.start()

        // THEN services reffer to the coordinator.
        XCTAssert(service1.coordinator === coordinatorUnderTest!)
        XCTAssert(service2.coordinator === coordinatorUnderTest!)
    }

    func test_stop_with_several_services() {
        // GIVEN a started coordinator with serveral services
        let service1 = CoordinatorServiceProtocolMock()
        let service2 = CoordinatorServiceProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service1, service2])
        coordinatorUnderTest?.start()

        // WHEN stopping the Coordination
        coordinatorUnderTest?.stop()

        // THEN the service are stopped
        XCTAssert(service1.startCalled)
        XCTAssert(service1.stopCalled)
        XCTAssert(service2.startCalled)
        XCTAssert(service2.stopCalled)
    }

}
