import UIKit
import JToolKit
import Coordinator
import RData
import QueueManagementService
import MediaFileSystem

private typealias ConcurrencyTask = _Concurrency.Task

/// Coordinator to control the logged in workflow.
class AppCoordinator: BaseFlowCoordinator {

    /// Defining the default services that the `LoggedInCoordinator` will be started with.
    private static let appServices: [CoordinatorServiceProtocol] = [
        AppQueueManagementService.shared,
        AppMediaManagementService(fileSystem: MediaFileSystemBuilder.shared)
    ]

    // Access to the only instance of this coordinator.
    // DevNote: This will be handle by the AppCoordinator in the future.
    static var shared = AppCoordinator()

    // single data repository
    let sharedDataRepository = LecturesRepositoryBuilder.build()

    // Single file system
    let mediaFileSystem = MediaFileSystemBuilder.shared

    // When we receive a Local notification the login coordinator is not yet alive since
    // we still do not know if the user is logged in or not. In that case we hold this static
    // var to attend the notification once the login is coordinator is ready.
    static var pendingNotificationId: String?

    var childCoordinators: [FlowCoordinator] = []

    /// Initialize the coordinator.
    ///
    /// The coordinator will also initialize a list of services conforming to `CoordinatorServiceProtocol`.
    /// The services will be started and stopped when the coordinator is.
    ///
    /// Among the services, a `ContextProviderProtocol` can be passed. If it exist, it will
    /// be used as a source to update the Coordinator Context.
    ///
    /// - Parameter services: A list of services associated with the coordinator.
    init(services: [CoordinatorServiceProtocol] = appServices) {

        super.init(managersTypeMapping: AppCoordinatorMapping,
                   services: services)
    }

    override func start() {

        super.start()
        // The login coordinator needs to handle any pending local notification when
        // we login in case entre from cold launch.
        dispatchLocalNotificationIfAny()
    }

    func dispatchLocalNotificationIfAny() {

        // If there is any pending notification dispatch it.
        if let notificationId = AppCoordinator.pendingNotificationId {

            services.forEach { $0.attendToLocalNotification(identifier: notificationId) }
            AppCoordinator.pendingNotificationId = nil
        }
    }

    // MARK: - Coordination

    // The coordination of the login coordinator is a bid different than the one on the
    // `BaseFlowCoordinator`. In this section we change the way coordination is done since
    // the login Coordinator deals with a tab View controller instead of navigation.

    override func coordinate(from module: Coordinated, request: CoordinationRequest) {

        //log.debug("Coordinate from module \(module), request: \(request)")

        // The logged in coordinator is a variation of a regular flow Controller.
        // Whilsh a regular flow controller has navigation this one has a tab controller.
        // It does not redirect unmapped actions to the parent but to the current tab
        // cooordinator.
        if managersTypeMapping[request.name] != nil {

            super.coordinate(from: module, request: request)
        } else {

            ConcurrencyTask { @MainActor in

                self.currentSubCoordinator()?.coordinate(from: module, request: request)
            }
        }
    }

    /// Allows access to the current subcoordinator.
    ///
    /// This coordinator coordinates a tab controller with a flowController on every tab.
    /// And, needs to dispatch unhandled request to the current one.
    private func currentSubCoordinator() -> FlowCoordinator? {

        let currentNavigationController = currentNavigationController()
        let currentSubcoordinator = childCoordinators.first { coordinator in
            coordinator.navigationController == currentNavigationController
        }
        return currentSubcoordinator
    }

    private func currentNavigationController() -> UINavigationController? {

        if let tabViewController = rootViewController as? UITabBarController {

            return tabViewController.selectedViewController as? UINavigationController
        }

        return nil
    }

    // MARK: - Life cycle events

    override func willEnterForeground() {

        // The login coordinator needs to handle any pending local notification when
        // we come to foreground.
        dispatchLocalNotificationIfAny()
        super.willEnterForeground()
    }
}
