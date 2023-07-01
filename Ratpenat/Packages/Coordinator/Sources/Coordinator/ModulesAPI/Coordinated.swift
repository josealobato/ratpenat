import Foundation

/// The `Coordinated` enumeration identify all modules that are allowed
/// to send a request to a coordinator.
public enum Coordinated: String, Equatable {

    /// Modules
    /// This case list is potentially lengthy,
    /// so please keep it sorted alphabetically.
    case lectureCollection

    /// Services
    /// This case list is potentially lengthy,
    /// so please keep it sorted alphabetically.
}
