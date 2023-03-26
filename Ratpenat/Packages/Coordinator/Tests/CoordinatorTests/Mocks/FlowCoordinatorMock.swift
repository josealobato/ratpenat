import UIKit
@testable import Coordinator

class FCMock: FlowCoordinator {

    var context: Coordinator.CoordinatorContext?

    var rootViewController: UIViewController?

    var parentCoordinator: Coordinator.FlowCoordinator?

    var navigationController: UINavigationController?

    var requestManagers: [Coordinator.RequestCoordinatorManager]

    func managerDidFinish(_ manager: Coordinator.RequestCoordinatorManager) { }

    init(navigationController: UINavigationController? = nil,
         requestManagers: [Coordinator.RequestCoordinatorManager]) {

        self.navigationController = navigationController
        self.requestManagers = requestManagers
    }

    var coordinateFromRequestCalled = false
    var coordinateFromRequestWithRequest: CoordinationRequest!
    func coordinate(from module: Coordinator.Coordinated, request: Coordinator.CoordinationRequest) {
        coordinateFromRequestCalled = true
        coordinateFromRequestWithRequest = request
    }
}
