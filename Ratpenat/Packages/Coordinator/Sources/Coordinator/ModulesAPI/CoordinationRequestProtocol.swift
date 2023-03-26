import Foundation
import JToolKit

/// Interface offered by a Coordinator.
public protocol CoordinationRequestProtocol: AnyObject, AutoMockable {

    /// Request for coordination
    ///
    /// Whenever a module needs an action that is out of its responsibilities,
    /// it will request an external coordinator to perform it on its behalf.
    /// This abstraction prevents a given module from knowing how to create
    /// and present other modules or show information to the user.
    ///
    /// Notice that this interface is using basic foundation types. This design aims
    /// to reduce coupling between modules.
    ///
    ///  ```
    ///  coordinate(from: TaskCreatorModule.Identifier,
    ///             request: .showTimeCreator(ignoreDraft: False))
    ///  ```
    ///
    /// - Parameters:
    ///   - module: The module requesting the coordination action.
    ///   The Coordinator will know that this identifier belongs to a give module
    ///   so it will take the proper action for the request.
    ///
    ///   - request: The request identifier.
    ///   The Module will describe what did trigger this
    ///   action: "task-created", "notification-received", "person-selected". **Avoid informations
    ///   about what should happen with the request**.
    ///   Available actions can be found in `CoordinationRequest`
    ///
    func coordinate(from module: Coordinated, request: CoordinationRequest)
}
