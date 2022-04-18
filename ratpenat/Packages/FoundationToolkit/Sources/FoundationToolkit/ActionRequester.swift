import Foundation

public typealias ActionRequest = (String) -> Void

/// The action Requester Protocol provides the contract for a Feature
/// to request the coordinator to take action.
public protocol ActionRequester {
    var actionRequest: ActionRequest { get set }
}
