import XCTest
@testable import Coordinator

/// In this test case we test that:
/// * The Coordinator use the Context Provider Service (CPS) to allow any manager
///   access the context. This is done in two ways:
///   1. Directly if the context is already available.
///   2. Asyncronously if the context has not been loaded already.
final class FlowCoordinatorContextToManagersTest: XCTestCase {

    /// Dev note: In these test we are using async/await

    var coordinatorUnderTest: BaseFlowCoordinator?
    var contextProviderService: ContextProviderServiceProtocolMock?

    override func setUp() {

        // Given a flow coordinator with...
        let mapping: RequestCoordinatorMappingDictionary = [
            // ... a manager ...
            CoordinationRequestName.showMessageDetails: RCMWithContextMock.self
        ]
        // ... and a context request service.
        contextProviderService = ContextProviderServiceProtocolMock()

        coordinatorUnderTest = BaseFlowCoordinator(managersTypeMapping: mapping, services: [contextProviderService!])

        // ... the coordinator is started to load the services (since the context provider is a service).
        coordinatorUnderTest?.start()
    }

    override func tearDown() { }

    // MARK: - The context is directly available

    func test_the_context_is_available_to_the_manager_when_directly_available_on_the_provider() {

        // and a context is present on the context provider
        let aContext = ContextMock()
        contextProviderService!.contextReturnValue = aContext

        // (expectation preparation)
        let contextUpdatExpectation = XCTestExpectation(description: "Request context update")
        RCMWithContextMock.coordinateFromRequestClosure = { _,_ in contextUpdatExpectation.fulfill() }
        RCMWithContextMock.contextOnCoordinate = nil

        // WHEN a coordination request happen,
        coordinatorUnderTest?.coordinate(from: .searchModule, request: .showMessageDetails(messageId: 666, replyId: 111))

        // THEN the manager should had access to the context.
        wait(for: [contextUpdatExpectation], timeout: 1.0)
        if let givenContext = RCMWithContextMock.contextOnCoordinate as? ContextMock {
            XCTAssert(givenContext == aContext)
        } else { XCTAssert(false) }
    }

    // MARK: - The context is NOT directly available, so we will request an update

    func test_the_context_is_available_to_the_manager_after_refresh_when_NOT_directly_available_on_the_provider() {

        // and a context is NOT present on the context provider
        contextProviderService!.contextReturnValue = nil
        let aContext = ContextMock()
        contextProviderService!.refreshContextReturnValue = aContext
        contextProviderService!.refreshContextClosure = {
            // NOTE: Here we simulate that the context is refreshed so it is available to the next call
            // to `context`.
            self.contextProviderService!.contextReturnValue = aContext
        }

        // (expectation preparation)
        let contextUpdatExpectation = XCTestExpectation(description: "Request context update")
        RCMWithContextMock.coordinateFromRequestClosure = { _,_ in contextUpdatExpectation.fulfill() }
        RCMWithContextMock.contextOnCoordinate = nil

        // WHEN a coordination request happen,
        coordinatorUnderTest?.coordinate(from: .searchModule, request: .showMessageDetails(messageId: 666, replyId: 111))

        // THEN the manager should had access to the context.
        wait(for: [contextUpdatExpectation], timeout: 1.0)
        if let givenContext = RCMWithContextMock.contextOnCoordinate as? ContextMock {
            XCTAssert(givenContext == aContext)
        } else { XCTAssert(false) }
    }
}
