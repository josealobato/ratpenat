import Foundation
import XCTest
@testable import Coordinator

///
/// This case test having a parent and child coordinator with and without context.
/// The child will make use of the parent context when available if it does not have one.
///
final class FlowCoordinatorContextFromParentCoordinatorTest: XCTestCase {

    var parentCoordinator: BaseFlowCoordinator?
    var childCoordinator: BaseFlowCoordinator?

    var servicesWithoutContextProvider: [CoordinatorServiceProtocol]?

    var childcontextProviderService: ContextProviderServiceProtocolMock?
    var childServicesWithContextProvider: [CoordinatorServiceProtocol]?
    let childContext = ContextMock()

    var parentcontextProviderService: ContextProviderServiceProtocolMock?
    var parentServicesWithContextProvider: [CoordinatorServiceProtocol]?
    let parentContext = ContextMock()

    override func setUp() {

        servicesWithoutContextProvider = []

        // Context provider and context what will be assigned to the child coordinator
        childcontextProviderService = ContextProviderServiceProtocolMock()
        childcontextProviderService!.contextReturnValue = childContext
        childServicesWithContextProvider = [childcontextProviderService!]

        // Context provider and context what will be assigned to the parent coordinator
        parentcontextProviderService = ContextProviderServiceProtocolMock()
        parentcontextProviderService!.contextReturnValue = childContext
        parentServicesWithContextProvider = [parentcontextProviderService!]

    }

    func test_parent_and_child_without_context() {

        // GIVEN a struct parent-child of coordinators
        // and none have context.
        parentCoordinator = BaseFlowCoordinator(managersTypeMapping: [:],
                                                services: servicesWithoutContextProvider!)
        childCoordinator = BaseFlowCoordinator(managersTypeMapping: [:],
                                               services:servicesWithoutContextProvider!)
        childCoordinator?.parentCoordinator = parentCoordinator

        // WHEN the manager request a context from the child coordinator
        // THEN it gets none.
        XCTAssertNil(childCoordinator?.context)
    }

    func test_parent_without_context_child_with_context() {

        // GIVEN a struct parent-child of coordinators
        // and the child has a context
        parentCoordinator = BaseFlowCoordinator(managersTypeMapping: [:],
                                                services: servicesWithoutContextProvider!)
        childCoordinator = BaseFlowCoordinator(managersTypeMapping: [:],
                                               services: childServicesWithContextProvider!)
        childCoordinator?.parentCoordinator = parentCoordinator

        // WHEN the manager request a context from the child coordinator
        // THEN it gets the child coordinator context.
        if let givenContext = childCoordinator?.context as? ContextMock {
            XCTAssert(givenContext == childContext)
        } else { XCTAssert(false) }
    }

    func test_parent_with_context_child_without_context() {

        // GIVEN a struct parent-child of coordinators
        // and only the parent has context
        parentCoordinator = BaseFlowCoordinator(managersTypeMapping: [:],
                                                services: parentServicesWithContextProvider!)
        childCoordinator = BaseFlowCoordinator(managersTypeMapping: [:],
                                               services: servicesWithoutContextProvider!)
        childCoordinator?.parentCoordinator = parentCoordinator

        // WHEN the manager request a context from the child coordinator
        // THEN it gets the child coordinator context.
        if let givenContext = childCoordinator?.context as? ContextMock {
            XCTAssert(givenContext == parentContext)
        } else { XCTAssert(false) }
    }

    func test_parent_with_context_child_with_context() {

        // GIVEN a struct parent-child of coordinators
        // and both have context
        parentCoordinator = BaseFlowCoordinator(managersTypeMapping: [:],
                                                services: parentServicesWithContextProvider!)
        childCoordinator = BaseFlowCoordinator(managersTypeMapping: [:],
                                               services: childServicesWithContextProvider!)
        childCoordinator?.parentCoordinator = parentCoordinator

        // WHEN the manager request a context from the child coordinator
        // THEN it gets the child coordinator context.
        if let givenContext = childCoordinator?.context as? ContextMock {
            XCTAssert(givenContext == childContext)
        } else { XCTAssert(false) }
    }
}


