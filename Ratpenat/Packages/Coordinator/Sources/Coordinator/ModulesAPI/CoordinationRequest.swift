import Foundation
import JToolKit
import Entities

/// Definition of request made using the Coordinator Protocol.
public enum CoordinationRequest: Equatable {

    /// This case list is potentially lengthy,
    /// so please keep it sorted alphabetically.
    case dismiss
    case showLectureDetails(id: String)

    public var name: CoordinationRequestName {

        var value: CoordinationRequestName
        switch self {

        /// This case list is potentially lengthy,
        /// so please keep it sorted alphabetically.
        case .dismiss: value = CoordinationRequestName.dismiss
        case .showLectureDetails: value = CoordinationRequestName.showLectureDetails
        }

        return value
    }

    // MARK: - Equatable
    // swiftlint:disable:next cyclomatic_complexity function_body_length
    public static func == (lhs: CoordinationRequest, rhs: CoordinationRequest) -> Bool {

        /// This case list is potentially lengthy,
        /// so please keep it sorted alphabetically.
        switch (lhs, rhs) {

        case (.dismiss, .dismiss): return true
        case let (.showLectureDetails(lhsId), .showLectureDetails(rhsId)): return lhsId == rhsId

        default: return false
        }
    }
}
