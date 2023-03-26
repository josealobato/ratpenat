import Foundation
import JToolKit

/// A coordinator services can be attached to a Coordinator to be controlled
/// within the flow of the coordinator.
public protocol CoordinatorServiceProtocol: AutoMockable, AnyObject {

    /// Access to a coordinator.
    /// The services can access the coordinator to request coordination as a
    /// result of one its actions.
    var coordinator: CoordinationRequestProtocol? { get set }

    /// When the service receives a local notification this will be called
    /// - Parameter identifier: the identifier used for the local notification
    func attendToLocalNotification(identifier: String)

    /// Start the coordination service.
    func start()

    /// Stop the coordination service.
    func stop()
}

public extension CoordinatorServiceProtocol {

    // By default the services do nothing on nofication call
    func attendToLocalNotification(identifier: String) { }
}

/// A service that is aware of the app life cycle.
/// Sometimes a service needs to know about the basic life cycle events of the
/// application. In that case this is a specializatio of the basic one.
public protocol CoordinatorServiceLifeCycleProtocol: CoordinatorServiceProtocol {

    func willEnterForeground()
    func didEnterForeground()
    func willEnterBackground()
    func didEnterBackground()
}

/// Extension to provide default implementation. Most of the time
/// we do not need all methods, so just implement the one needed.
public extension CoordinatorServiceLifeCycleProtocol {

    func willEnterForeground() { }
    func didEnterForeground() { }
    func willEnterBackground() { }
    func didEnterBackground() { }
}
