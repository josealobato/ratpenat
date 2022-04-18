import UIKit
import AllCollectionFeature
import HomeFeature

/// We could have a tree of coordinators. The AppCoordinator is the
/// starting point of the tree.
/// The AppCoordinator is in charge of setting up the Application.
class AppCoordinator: BaseCoordinator {

    /// The app coordinator keep reference to the main window of the
    /// app that coordinates.
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {

        window.rootViewController = setTabVC()
        window.makeKeyAndVisible()
    }

    private func setTabVC() -> UITabBarController {

        // Home.
        let homeNavigation = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigation: homeNavigation)
        homeCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: homeCoordinator)
        }
        self.store(coordinator: homeCoordinator)
        homeCoordinator.start()

        // Feature One.
        let allCollectionNavigation = UINavigationController()
        let allCollectionCoordinator = AllCollectionCoordinator(navigation: allCollectionNavigation)
        allCollectionCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: allCollectionCoordinator)
        }
        self.store(coordinator: allCollectionCoordinator)
        allCollectionCoordinator.start()

        // Build the tab bar VC.
        let tabVC = UITabBarController()
        tabVC.viewControllers = [homeNavigation, allCollectionNavigation]
        tabVC.selectedIndex = 0

        return tabVC
    }
}
