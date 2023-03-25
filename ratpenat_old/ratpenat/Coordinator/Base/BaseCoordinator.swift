import UIKit

/// BaseCoordinator is the parent class to all coordinator to provide
/// common features.
class BaseCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController?

    var isCompleted: (() -> Void)?

    func start() {
        fatalError("Children Should implement `start`.")
    }
}
