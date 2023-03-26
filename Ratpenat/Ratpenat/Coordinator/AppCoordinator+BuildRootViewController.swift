import UIKit
import Coordinator

extension AppCoordinator {

    func buildRootViewController() -> UIViewController? {

        guard rootViewController == nil else { return rootViewController }

        // Home.
        let homeNavigation = UINavigationController()
        homeNavigation.pushViewController(HomeVC(), animated: false)
        let homeCoordinator = BaseFlowCoordinator(managersTypeMapping: coordinatorManagersMapping)
        homeCoordinator.navigationController = homeNavigation
        homeCoordinator.parentCoordinator = self
        childCoordinators.append(homeCoordinator)
        //homeCoordinator.start()

        // Home 2
        let homeNavigation2 = UINavigationController()
        homeNavigation2.pushViewController(HomeVC(), animated: false)
        let homeCoordinator2 = BaseFlowCoordinator(managersTypeMapping: coordinatorManagersMapping)
        homeCoordinator2.navigationController = homeNavigation
        homeCoordinator2.parentCoordinator = self
        childCoordinators.append(homeCoordinator2)
        //homeCoordinator.start()

        // Build the tab bar VC.
        let tabVC = UITabBarController()
        tabVC.viewControllers = [homeNavigation, homeNavigation2]
        tabVC.selectedIndex = 0

        rootViewController = tabVC
        return rootViewController
    }
    
}
