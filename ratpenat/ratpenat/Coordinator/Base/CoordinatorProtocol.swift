import UIKit

/// A coordinator is defined by
/// * its capability to hold other coordintors.
/// * controls a navigation.
/// * should be started.
protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
        
    func start()
}

/// In this extension we define common basic methods that are useful to
/// all coordinators.
extension Coordinator {
    
    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator}
    }
}
