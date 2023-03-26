import XCTest
@testable import Coordinator

///
/// In this case we are testing that life cycle services receives the
/// life cycle events.
///
final class FlowCoordinatorLifeServicesTest: XCTestCase {
    
    var coordinatorUnderTest: BaseFlowCoordinator?
    
    override func setUp() { }
    
    override func tearDown() { }

    // MARK: - life cycle calls when NOT started.
    
    func test_life_cycle_service_with_stoped_coordinator() {
        // Given a non started coordinator with serveral life cycle services
        let service1 = CoordinatorServiceLifeCycleProtocolMock()
        let service2 = CoordinatorServiceLifeCycleProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service1, service2])

        // When receiving any event call
        coordinatorUnderTest?.willEnterForeground()
        coordinatorUnderTest?.didEnterForeground()
        coordinatorUnderTest?.willEnterBackground()
        coordinatorUnderTest?.didEnterBackground()

        // Then none life cycle services will receive this signal
        XCTAssertFalse(service1.willEnterForegroundCalled)
        XCTAssertFalse(service1.didEnterForegroundCalled)
        XCTAssertFalse(service1.willEnterBackgroundCalled)
        XCTAssertFalse(service1.didEnterBackgroundCalled)
    }

    // MARK: - life cycle calls when started.

    func test_life_cycle_service_with_no_call() {
        // Given a started coordinator with serveral life cycle services
        let service1 = CoordinatorServiceLifeCycleProtocolMock()
        let service2 = CoordinatorServiceLifeCycleProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service1, service2])
        coordinatorUnderTest?.start()

        // When receiving no call

        // Then all life cycle will receive this signal
        XCTAssertFalse(service1.willEnterForegroundCalled)
        XCTAssertFalse(service1.didEnterForegroundCalled)
        XCTAssertFalse(service1.willEnterBackgroundCalled)
        XCTAssertFalse(service1.didEnterBackgroundCalled)
    }

    func test_life_cycle_service_willEnterForeground() {
        // Given a started coordinator with serveral life cycle services
        let service1 = CoordinatorServiceLifeCycleProtocolMock()
        let service2 = CoordinatorServiceLifeCycleProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service1, service2])
        coordinatorUnderTest?.start()

        // When receiving willEnterForeground
        coordinatorUnderTest?.willEnterForeground()

        // Then all life cycle will receive this signal
        XCTAssert(service1.willEnterForegroundCalled)
        XCTAssertFalse(service1.didEnterForegroundCalled)
        XCTAssertFalse(service1.willEnterBackgroundCalled)
        XCTAssertFalse(service1.didEnterBackgroundCalled)
    }

    func test_life_cycle_service_didEnterForeground() {
        // Given a started coordinator with serveral life cycle services
        let service1 = CoordinatorServiceLifeCycleProtocolMock()
        let service2 = CoordinatorServiceLifeCycleProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service1, service2])
        coordinatorUnderTest?.start()

        // When receiving didEnterForeground
        coordinatorUnderTest?.didEnterForeground()

        // Then all life cycle will receive this signal
        XCTAssertFalse(service1.willEnterForegroundCalled)
        XCTAssert(service1.didEnterForegroundCalled)
        XCTAssertFalse(service1.willEnterBackgroundCalled)
        XCTAssertFalse(service1.didEnterBackgroundCalled)
    }

    func test_life_cycle_service_willEnterBackground() {
        // Given a started coordinator with serveral life cycle services
        let service1 = CoordinatorServiceLifeCycleProtocolMock()
        let service2 = CoordinatorServiceLifeCycleProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service1, service2])
        coordinatorUnderTest?.start()

        // When receiving willEnterBackground
        coordinatorUnderTest?.willEnterBackground()

        // Then all life cycle will receive this signal
        XCTAssertFalse(service1.willEnterForegroundCalled)
        XCTAssertFalse(service1.didEnterForegroundCalled)
        XCTAssert(service1.willEnterBackgroundCalled)
        XCTAssertFalse(service1.didEnterBackgroundCalled)
    }

    func test_life_cycle_service_didEnterBackground() {
        // Given a started coordinator with serveral life cycle services
        let service1 = CoordinatorServiceLifeCycleProtocolMock()
        let service2 = CoordinatorServiceLifeCycleProtocolMock()
        coordinatorUnderTest = BaseFlowCoordinator(services: [service1, service2])
        coordinatorUnderTest?.start()

        // When receiving didEnterBackground
        coordinatorUnderTest?.didEnterBackground()

        // Then all life cycle will receive this signal
        XCTAssertFalse(service1.willEnterForegroundCalled)
        XCTAssertFalse(service1.didEnterForegroundCalled)
        XCTAssertFalse(service1.willEnterBackgroundCalled)
        XCTAssert(service1.didEnterBackgroundCalled)
    }
}
