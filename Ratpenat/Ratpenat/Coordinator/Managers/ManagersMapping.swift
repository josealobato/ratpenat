import UIKit
import Coordinator

// Requests that should be handle by the Logging coordinator
// swiftlint:disable:next prefixed_toplevel_constant
let AppCoordinatorMapping: RequestCoordinatorMappingDictionary = [:]

// Request that could be handle by any flow coordinator.
// Usually are the ones handle by pushing on the current tab.
// swiftlint:disable:next prefixed_toplevel_constant
let coordinatorManagersMapping: RequestCoordinatorMappingDictionary = [

    /// This list is potentially lengthy,
    /// so please keep it sorted alphabetically.
    CoordinationRequestName.dismiss: DismissManager.self,
    CoordinationRequestName.showLectureDetails: LectureDetailsManager.self
]
