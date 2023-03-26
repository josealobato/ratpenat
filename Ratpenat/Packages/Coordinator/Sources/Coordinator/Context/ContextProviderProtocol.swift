import Foundation
//import TeamworkUtils

/// The `ContextProviderProtocol` defines an object that can
/// be used by the Coordinator to hold the context and update the context.
///
/// **Rationale:** The Coordinator needs a service to hold and maintain a fresh
/// version of the context. One of the services can do this job. That service will
/// conform to this protocol and the Coordinator will use it to keep its
/// context up to date.
///
/// This service will use the regular Services life cycle calls to update the
/// context (instead of doing it in every call).
///
public protocol ContextProviderProtocol {

    associatedtype ContextType: CoordinatorContext

    /// Get last context state.
    /// This call does not force a request instead you get the context
    /// from the last update.
    ///
    ///  **Rationale**: The context provides should take care of having a
    ///  fresh enough context, but if the context has not yet arrived, it will
    ///  inform by returning nil.
    ///
    /// - Returns: the last updated context if any
    func context() -> ContextType?

    /// Request a fresh context by forcing the update.
    /// Since the context might contain remote data this call is async.
    ///
    /// **Attention** do this call only when necessary since it might involve
    /// request to remote services.
    ///
    /// - Returns: the updated context
    @discardableResult func refreshContext() async throws -> ContextType
}
