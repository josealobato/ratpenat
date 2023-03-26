import Foundation

open class RequestCoordinatorManager: CoordinationRequestProtocol {

    public var parentCoordinator: Coordinator.FlowCoordinator

    public required init(parentCoordinator: Coordinator.FlowCoordinator) {

        self.parentCoordinator = parentCoordinator
    }

    open func coordinate(from module: Coordinated, request: CoordinationRequest) {

        assert(false, "This method should be overriden.")
    }
}
