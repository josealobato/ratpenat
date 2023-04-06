import UIKit
import Coordinator
import LectureCollection
import RData

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

        // List
        let listNavigation = buildLectureListTabContent()
        let ListCoordinator = BaseFlowCoordinator(managersTypeMapping: coordinatorManagersMapping)
        ListCoordinator.navigationController = listNavigation
        ListCoordinator.parentCoordinator = self
        childCoordinators.append(ListCoordinator)
        //homeCoordinator.start()

        // Build the tab bar VC.
        let tabVC = UITabBarController()
        tabVC.viewControllers = [homeNavigation, listNavigation]
        tabVC.selectedIndex = 0

        rootViewController = tabVC
        return rootViewController
    }

    private func buildLectureListTabContent() -> UINavigationController {

        let listNavigation = UINavigationController()

        let listRepository = LecturesRepositoryBuilder.build()
        let listAdapter = LectureCollectionAdapter(repository: listRepository)
        let listVC = LectureCollectionBuilder.build(services: listAdapter)

        listVC.tabBarItem.image = UIImage(systemName: "books.vertical")
        listVC.tabBarItem.title = "Library"

        listNavigation.pushViewController(listVC, animated: false)

        return listNavigation
    }
    
}
