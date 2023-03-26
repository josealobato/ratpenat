import Foundation
@testable import Coordinator

/// NOTE:
/// RCM = Request Coordinator Manager

class RCMMock1: RequestCoordinatorManager {

    var coordinateFromRequestCalled = false
    var coordinateFromRequestWithRequest: CoordinationRequest!
    var context: CoordinatorContext?
    override func coordinate(from module: Coordinator.Coordinated,
                    request: Coordinator.CoordinationRequest) {
        coordinateFromRequestCalled = true
        coordinateFromRequestWithRequest = request
    }
}

class RCMMock2: RequestCoordinatorManager {

    var coordinateFromRequestCalled = false
    var coordinateFromRequestWithRequest: CoordinationRequest!
    override func coordinate(from module: Coordinator.Coordinated,
                    request: Coordinator.CoordinationRequest) {
        coordinateFromRequestCalled = true
        coordinateFromRequestWithRequest = request
    }
}

/// This mocks keeps the latest context on a static for later inspection.
/// NOTICE: that the coordinator creates and destroys managers as needed.
class RCMWithContextMock: RequestCoordinatorManager {

    static var contextOnCoordinate: CoordinatorContext?

    var coordinateFromRequestCalled = false
    var coordinateFromRequestWithRequest: CoordinationRequest!
    static var coordinateFromRequestClosure: ((Coordinator.Coordinated, Coordinator.CoordinationRequest) -> Void)?
    override func coordinate(from module: Coordinator.Coordinated,
                    request: Coordinator.CoordinationRequest) {
        coordinateFromRequestCalled = true
        coordinateFromRequestWithRequest = request
        RCMWithContextMock.contextOnCoordinate = parentCoordinator.context
        RCMWithContextMock.coordinateFromRequestClosure?(module, request)
    }
}
