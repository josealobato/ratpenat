import Foundation

/// Generic Context
///
/// **Rationale:** Sometimes, like in the Coordinator, the context
/// handler doesn't need to know about the details of the context,
/// in this case this protocol can be used.
/// Other context should conform to this protocol.
public protocol CoordinatorContext { }
