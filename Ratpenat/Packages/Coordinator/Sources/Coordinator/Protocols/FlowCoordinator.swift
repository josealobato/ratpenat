import UIKit

public protocol FlowCoordinator: CoordinationRequestProtocol {

    /// Root view controller.
    /// Sometimes the coordinator or the manager will need to present
    /// at the root level. For those cases the flow coordinator could offer
    /// the root view controller. Notice that a pure Flow coordinator won't
    /// offer a root view controller.
    var rootViewController: UIViewController? { get set }

    /// Navigation controller.
    /// As a general norm a flow coordinator will offer a navigation controller
    /// to allow pushing controllers.
    /// A flow controller could also control a tab controller, in that ocassion
    /// the navigation controller might reffer to the current selected navigation
    /// controller if any.
    var navigationController: UINavigationController? { get set }

    /// Access to the Parent coordinator.
    /// Child flow coordinators will use this access to delegate a request
    /// that they can not handle.
    var parentCoordinator: FlowCoordinator? { get set }

    /// Context associated with the Coordinator.
    var context: CoordinatorContext? { get }

    // MARK: - Managers controls

    // Current list of managers handled by the coordinator.
    var requestManagers: [RequestCoordinatorManager] { get }

    // A manager inform the Flow coordinator that it has finish its duty.
    func managerDidFinish(_ manager: RequestCoordinatorManager)
}
