import Foundation
import Entities

extension CoordinationRequest {

    /// Sometimes, specially during testing, we want to check that we are receiving the
    /// correct request independently of the parameters.
    /// `isSameRequest` is a method that mimic the `Equatable` `==` but not comparing the
    /// parameters just the enum case.
    /// 
    // swiftlint:disable:next cyclomatic_complexity function_body_length
    public static func isSameRequestCase(_ lhs: CoordinationRequest, _ rhs: CoordinationRequest) -> Bool {

        /// This case list is potentially lengthy,
        /// so please keep it sorted alphabetically.
        switch (lhs, rhs) {

        case (.dismiss, .dismiss): return true
        case (.showLectureDetails, .showLectureDetails): return true

        default:
            return false
        }
    }
}

