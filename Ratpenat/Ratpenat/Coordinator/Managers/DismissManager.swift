import UIKit
import Coordinator

final class DismissManager: RequestCoordinatorManager {

    override func coordinate(from module: Coordinator.Coordinated, request: Coordinator.CoordinationRequest) {

        if case .dismiss = request {

            parentCoordinator.navigationController?.dismiss( animated: true)
            parentCoordinator.managerDidFinish(self)
        }
    }
}
