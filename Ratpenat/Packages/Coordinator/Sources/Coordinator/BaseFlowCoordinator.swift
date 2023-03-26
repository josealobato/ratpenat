import UIKit

public typealias RequestCoordinatorMappingDictionary = [CoordinationRequestName: RequestCoordinatorManager.Type]

/// Base implementation of a flow coordinator.
/// It is adviced that all flow coordinators use or extend this class.
///
/// It provides the following functionality:
/// * **It handles managers dispatching**. Having a mapping dicctionary (in initialization) it
///     will dispath the request to the proper manager. If there is no manager it will defer it to
///     the parent manager if any.
/// * **Handle Managers list**. I will instanciate, dispatch, and dispose the manager for every request.
/// * **Services**. It will start and stop services, as well as passing life cycle events to
///                 those services that requires them.
/// * **Context**. When one of the services offers itself as a context manager the coordinator will offer
///                that context to all manager. It will also look for context in parent coordinators
///                when no context manager is available.
open class BaseFlowCoordinator: FlowCoordinator {

    public var rootViewController: UIViewController?
    public var navigationController: UINavigationController?
    public var parentCoordinator: FlowCoordinator?
    private var isStarted = false

    // MARK: - Services declaration
    // Two type of services:
    // The basic `services` are the ones started and stopped with the
    // Coordinator itself.
    // The `lifecycleServices` are services that also receive live cycle events.
    public let services: [CoordinatorServiceProtocol]
    private var lifecycleServices: [CoordinatorServiceLifeCycleProtocol] {

        services.compactMap { $0 as? CoordinatorServiceLifeCycleProtocol }
    }

    // MARK: - Managers declaration

    var managers: [RequestCoordinatorManager] = []
    public var managersTypeMapping: RequestCoordinatorMappingDictionary
    public var requestManagers: [RequestCoordinatorManager] {

        managers
    }

    // MARK: - Context

    // The Coordinator Context accessor.
    public var context: CoordinatorContext? {

        guard contextProvider != nil else { return parentCoordinator?.context }

        return contextProvider?.context()
    }

    // The service that can provide and keep updating the context.
    var contextProvider: (any ContextProviderProtocol)?

    // MARK: - Initialization

    public init(managersTypeMapping: RequestCoordinatorMappingDictionary = [:],
                services: [CoordinatorServiceProtocol] = []) {

        self.managersTypeMapping = managersTypeMapping
        self.services = services

        self.getContextProvider(fromServices: services)
    }

    // MARK: - Manage Coordinator Requests.

    open func coordinate(from module: Coordinated, request: CoordinationRequest) {

        Task { @MainActor in

            await self.updateContextIfNeeded()
            self.managerCoordination(from: module, request: request)
        }
    }

    func updateContextIfNeeded() async {

        if (contextProvider?.context()) == nil {

            _ = try? await contextProvider?.refreshContext()
        }
    }

    func managerCoordination(from module: Coordinated, request: CoordinationRequest) {

        if let availableManagerType = managersTypeMapping[request.name] {

            let instance = availableManagerType.init(parentCoordinator: self)
            managers.append(instance)
            instance.coordinate(from: module, request: request)
        } else {
            
            parentCoordinator?.coordinate(from: module,
                                          request: request)
        }
    }

    // MARK: - Dispose the Managers

    public func managerDidFinish(_ manager: RequestCoordinatorManager) {

        Task { @MainActor in

            self.disposingManager(manager)
        }
    }

    func disposingManager(_ manager: RequestCoordinatorManager) {

        if let index = managers.firstIndex(where: { $0 === manager }) {
            managers.remove(at: index)
        }
    }

    // MARK: - Life cycle

    open func start() {

        startServices()
        isStarted = true
    }

    open func stop() {

        stopServices()
        isStarted = false
    }

    // MARK: - Services

    private func startServices() {

        for service in services {

            let aService = service
            aService.coordinator = self
            aService.start()
        }
    }

    private func stopServices() {

        for service in services {

            service.stop()
        }
    }

    // MARK: - Life cycle events

    open func willEnterForeground() {

        guard isStarted else { return }
        lifecycleServices.forEach { $0.willEnterForeground() }
    }

    open func didEnterForeground() {

        guard isStarted else { return }
        lifecycleServices.forEach { $0.didEnterForeground() }
    }

    open func willEnterBackground() {

        guard isStarted else { return }
        lifecycleServices.forEach { $0.willEnterBackground() }
    }

    open func didEnterBackground() {

        guard isStarted else { return }
        lifecycleServices.forEach { $0.didEnterBackground() }
    }

    // MARK: - Managing the context

    private func getContextProvider(fromServices services: [CoordinatorServiceProtocol]) {

        // Check if there is any services that could provide the context.
        guard let contextProviderCandidate = services.first(where: { service in

            service is (any ContextProviderProtocol)
        }) as? (any ContextProviderProtocol) else { return }

        contextProvider = contextProviderCandidate
    }
}
