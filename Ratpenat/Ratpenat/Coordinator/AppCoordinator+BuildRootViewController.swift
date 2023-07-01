import UIKit
import QueueManagementService
import Coordinator
import LectureCollection
import QueueCollection
import RData
import Player

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

        // Player
        let playerVC = buildPlayerTabContent()

        // Queue Collection
        let queueNavigation = buildQueueListTabContent()
        let queueCoordinator = BaseFlowCoordinator(managersTypeMapping: coordinatorManagersMapping)
        queueCoordinator.navigationController = queueNavigation
        queueCoordinator.parentCoordinator = self
        childCoordinators.append(queueCoordinator)

        // List
        let listCoordinator = BaseFlowCoordinator(managersTypeMapping: coordinatorManagersMapping)
        let listNavigation = buildLectureListTabContent(coordiantor: listCoordinator)
        listCoordinator.navigationController = listNavigation
        listCoordinator.parentCoordinator = self
        childCoordinators.append(listCoordinator)

        // Build the tab bar VC.
        let tabVC = UITabBarController()
        tabVC.viewControllers = [playerVC, queueNavigation, listNavigation]
        tabVC.selectedIndex = 0

        rootViewController = tabVC
        return rootViewController
    }

    private func buildPlayerTabContent() -> UIViewController {

        let queueManagement = AppQueueManagementService.sharedService as QueueManagementServiceProtocol

        let playerAdater = PlayerAdapter(queueManagement: queueManagement)
        let playerVC = PlayerBuilder.build(services: playerAdater)

        playerVC.tabBarItem.image = UIImage(systemName: "play")
        playerVC.tabBarItem.title = "Player"

        return playerVC
    }

    private func buildLectureListTabContent(coordiantor: CoordinationRequestProtocol) -> UINavigationController {

        let listNavigation = UINavigationController()

        let queueManagement = AppQueueManagementService.sharedService as QueueManagementServiceProtocol

        let listAdapter = LectureCollectionAdapter(repository: sharedDataRepository,
                                                   queueManagement: queueManagement)
        let listVC = LectureCollectionBuilder.build(services: listAdapter,
                                                    coordinator: coordiantor)

        listVC.tabBarItem.image = UIImage(systemName: "books.vertical")
        listVC.tabBarItem.title = "Library"

        listNavigation.pushViewController(listVC, animated: false)

        return listNavigation
    }

    private func buildQueueListTabContent() -> UINavigationController {

        let listNavigation = UINavigationController()

        let queueManagement = AppQueueManagementService.sharedService as QueueManagementServiceProtocol

        let listAdapter = QueueCollectionAdapter(queueManagement: queueManagement)
        let listVC = QueueCollectionBuilder.build(services: listAdapter)

        listVC.tabBarItem.image = UIImage(systemName: "rectangle.stack")
        listVC.tabBarItem.title = "Queue"

        listNavigation.pushViewController(listVC, animated: false)

        return listNavigation
    }
    
}
