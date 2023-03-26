// Generated using Sourcery 1.7.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import Foundation
import UIKit

#if canImport(RxSwift)
import RxSwift
#endif
@testable import Coordinator; import TeamworkEntities;














final class CoordinationRequestProtocolMock: CoordinationRequestProtocol {

    //MARK: - coordinate

    var coordinateFromRequestCallsCount = 0
    var coordinateFromRequestCalled: Bool {
        return coordinateFromRequestCallsCount > 0
    }
    var coordinateFromRequestReceivedArguments: (module: Coordinated, request: CoordinationRequest)?
    var coordinateFromRequestReceivedInvocations: [(module: Coordinated, request: CoordinationRequest)] = []
    var coordinateFromRequestClosure: ((Coordinated, CoordinationRequest) -> Void)?

    func coordinate(from module: Coordinated, request: CoordinationRequest) {
        coordinateFromRequestCallsCount += 1
        coordinateFromRequestReceivedArguments = (module: module, request: request)
        coordinateFromRequestReceivedInvocations.append((module: module, request: request))
        coordinateFromRequestClosure?(module, request)
    }

}
final class CoordinatorServiceLifeCycleProtocolMock: CoordinatorServiceLifeCycleProtocol {
    var coordinator: CoordinationRequestProtocol?

    //MARK: - willEnterForeground

    var willEnterForegroundCallsCount = 0
    var willEnterForegroundCalled: Bool {
        return willEnterForegroundCallsCount > 0
    }
    var willEnterForegroundClosure: (() -> Void)?

    func willEnterForeground() {
        willEnterForegroundCallsCount += 1
        willEnterForegroundClosure?()
    }

    //MARK: - didEnterForeground

    var didEnterForegroundCallsCount = 0
    var didEnterForegroundCalled: Bool {
        return didEnterForegroundCallsCount > 0
    }
    var didEnterForegroundClosure: (() -> Void)?

    func didEnterForeground() {
        didEnterForegroundCallsCount += 1
        didEnterForegroundClosure?()
    }

    //MARK: - willEnterBackground

    var willEnterBackgroundCallsCount = 0
    var willEnterBackgroundCalled: Bool {
        return willEnterBackgroundCallsCount > 0
    }
    var willEnterBackgroundClosure: (() -> Void)?

    func willEnterBackground() {
        willEnterBackgroundCallsCount += 1
        willEnterBackgroundClosure?()
    }

    //MARK: - didEnterBackground

    var didEnterBackgroundCallsCount = 0
    var didEnterBackgroundCalled: Bool {
        return didEnterBackgroundCallsCount > 0
    }
    var didEnterBackgroundClosure: (() -> Void)?

    func didEnterBackground() {
        didEnterBackgroundCallsCount += 1
        didEnterBackgroundClosure?()
    }

    //MARK: - attendToLocalNotification

    var attendToLocalNotificationIdentifierCallsCount = 0
    var attendToLocalNotificationIdentifierCalled: Bool {
        return attendToLocalNotificationIdentifierCallsCount > 0
    }
    var attendToLocalNotificationIdentifierReceivedIdentifier: String?
    var attendToLocalNotificationIdentifierReceivedInvocations: [String] = []
    var attendToLocalNotificationIdentifierClosure: ((String) -> Void)?

    func attendToLocalNotification(identifier: String) {
        attendToLocalNotificationIdentifierCallsCount += 1
        attendToLocalNotificationIdentifierReceivedIdentifier = identifier
        attendToLocalNotificationIdentifierReceivedInvocations.append(identifier)
        attendToLocalNotificationIdentifierClosure?(identifier)
    }

    //MARK: - start

    var startCallsCount = 0
    var startCalled: Bool {
        return startCallsCount > 0
    }
    var startClosure: (() -> Void)?

    func start() {
        startCallsCount += 1
        startClosure?()
    }

    //MARK: - stop

    var stopCallsCount = 0
    var stopCalled: Bool {
        return stopCallsCount > 0
    }
    var stopClosure: (() -> Void)?

    func stop() {
        stopCallsCount += 1
        stopClosure?()
    }

}
final class CoordinatorServiceProtocolMock: CoordinatorServiceProtocol {
    var coordinator: CoordinationRequestProtocol?

    //MARK: - attendToLocalNotification

    var attendToLocalNotificationIdentifierCallsCount = 0
    var attendToLocalNotificationIdentifierCalled: Bool {
        return attendToLocalNotificationIdentifierCallsCount > 0
    }
    var attendToLocalNotificationIdentifierReceivedIdentifier: String?
    var attendToLocalNotificationIdentifierReceivedInvocations: [String] = []
    var attendToLocalNotificationIdentifierClosure: ((String) -> Void)?

    func attendToLocalNotification(identifier: String) {
        attendToLocalNotificationIdentifierCallsCount += 1
        attendToLocalNotificationIdentifierReceivedIdentifier = identifier
        attendToLocalNotificationIdentifierReceivedInvocations.append(identifier)
        attendToLocalNotificationIdentifierClosure?(identifier)
    }

    //MARK: - start

    var startCallsCount = 0
    var startCalled: Bool {
        return startCallsCount > 0
    }
    var startClosure: (() -> Void)?

    func start() {
        startCallsCount += 1
        startClosure?()
    }

    //MARK: - stop

    var stopCallsCount = 0
    var stopCalled: Bool {
        return stopCallsCount > 0
    }
    var stopClosure: (() -> Void)?

    func stop() {
        stopCallsCount += 1
        stopClosure?()
    }

}
final class FlowCoordinatorMock: FlowCoordinator {
    var rootViewController: UIViewController?
    var navigationController: UINavigationController?
    var parentCoordinator: FlowCoordinator?
    var context: CoordinatorContext?
    var requestManagers: [RequestCoordinatorManager] = []

    //MARK: - managerDidFinish

    var managerDidFinishCallsCount = 0
    var managerDidFinishCalled: Bool {
        return managerDidFinishCallsCount > 0
    }
    var managerDidFinishReceivedManager: RequestCoordinatorManager?
    var managerDidFinishReceivedInvocations: [RequestCoordinatorManager] = []
    var managerDidFinishClosure: ((RequestCoordinatorManager) -> Void)?

    func managerDidFinish(_ manager: RequestCoordinatorManager) {
        managerDidFinishCallsCount += 1
        managerDidFinishReceivedManager = manager
        managerDidFinishReceivedInvocations.append(manager)
        managerDidFinishClosure?(manager)
    }

    //MARK: - coordinate

    var coordinateFromRequestCallsCount = 0
    var coordinateFromRequestCalled: Bool {
        return coordinateFromRequestCallsCount > 0
    }
    var coordinateFromRequestReceivedArguments: (module: Coordinated, request: CoordinationRequest)?
    var coordinateFromRequestReceivedInvocations: [(module: Coordinated, request: CoordinationRequest)] = []
    var coordinateFromRequestClosure: ((Coordinated, CoordinationRequest) -> Void)?

    func coordinate(from module: Coordinated, request: CoordinationRequest) {
        coordinateFromRequestCallsCount += 1
        coordinateFromRequestReceivedArguments = (module: module, request: request)
        coordinateFromRequestReceivedInvocations.append((module: module, request: request))
        coordinateFromRequestClosure?(module, request)
    }

}
