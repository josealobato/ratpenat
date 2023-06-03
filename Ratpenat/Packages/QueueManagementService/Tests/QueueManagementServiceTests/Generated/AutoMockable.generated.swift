// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

@testable import QueueManagementService; import Entities; import RData;














final class LecturesRepositoryIntefaceCRUDMock: LecturesRepositoryIntefaceCRUD {

    //MARK: - add

    var addLectureThrowableError: Error?
    var addLectureCallsCount = 0
    var addLectureCalled: Bool {
        return addLectureCallsCount > 0
    }
    var addLectureReceivedLecture: LectureDataEntity?
    var addLectureReceivedInvocations: [LectureDataEntity] = []
    var addLectureClosure: ((LectureDataEntity) throws -> Void)?

    func add(lecture: LectureDataEntity) async throws {
        if let error = addLectureThrowableError {
            throw error
        }
        addLectureCallsCount += 1
        addLectureReceivedLecture = lecture
        addLectureReceivedInvocations.append(lecture)
        try addLectureClosure?(lecture)
    }

    //MARK: - lectures

    var lecturesThrowableError: Error?
    var lecturesCallsCount = 0
    var lecturesCalled: Bool {
        return lecturesCallsCount > 0
    }
    var lecturesReturnValue: [LectureDataEntity]!
    var lecturesClosure: (() throws -> [LectureDataEntity])?

    func lectures() async throws -> [LectureDataEntity] {
        if let error = lecturesThrowableError {
            throw error
        }
        lecturesCallsCount += 1
        return try lecturesClosure.map({ try $0() }) ?? lecturesReturnValue
    }

    //MARK: - lecture

    var lectureWithIdThrowableError: Error?
    var lectureWithIdCallsCount = 0
    var lectureWithIdCalled: Bool {
        return lectureWithIdCallsCount > 0
    }
    var lectureWithIdReceivedId: String?
    var lectureWithIdReceivedInvocations: [String] = []
    var lectureWithIdReturnValue: LectureDataEntity?
    var lectureWithIdClosure: ((String) throws -> LectureDataEntity?)?

    func lecture(withId id: String) async throws -> LectureDataEntity? {
        if let error = lectureWithIdThrowableError {
            throw error
        }
        lectureWithIdCallsCount += 1
        lectureWithIdReceivedId = id
        lectureWithIdReceivedInvocations.append(id)
        return try lectureWithIdClosure.map({ try $0(id) }) ?? lectureWithIdReturnValue
    }

    //MARK: - update

    var updateLectureThrowableError: Error?
    var updateLectureCallsCount = 0
    var updateLectureCalled: Bool {
        return updateLectureCallsCount > 0
    }
    var updateLectureReceivedLecture: LectureDataEntity?
    var updateLectureReceivedInvocations: [LectureDataEntity] = []
    var updateLectureClosure: ((LectureDataEntity) throws -> Void)?

    func update(lecture: LectureDataEntity) async throws {
        if let error = updateLectureThrowableError {
            throw error
        }
        updateLectureCallsCount += 1
        updateLectureReceivedLecture = lecture
        updateLectureReceivedInvocations.append(lecture)
        try updateLectureClosure?(lecture)
    }

    //MARK: - delete

    var deleteWithIdThrowableError: Error?
    var deleteWithIdCallsCount = 0
    var deleteWithIdCalled: Bool {
        return deleteWithIdCallsCount > 0
    }
    var deleteWithIdReceivedId: String?
    var deleteWithIdReceivedInvocations: [String] = []
    var deleteWithIdClosure: ((String) throws -> Void)?

    func delete(withId id: String) async throws {
        if let error = deleteWithIdThrowableError {
            throw error
        }
        deleteWithIdCallsCount += 1
        deleteWithIdReceivedId = id
        deleteWithIdReceivedInvocations.append(id)
        try deleteWithIdClosure?(id)
    }

}
final class QueueManagementServiceProtocolMock: QueueManagementServiceProtocol {

    //MARK: - getQueue

    var getQueueCallsCount = 0
    var getQueueCalled: Bool {
        return getQueueCallsCount > 0
    }
    var getQueueReturnValue: [Lecture]!
    var getQueueClosure: (() -> [Lecture])?

    func getQueue() -> [Lecture] {
        getQueueCallsCount += 1
        return getQueueClosure.map({ $0() }) ?? getQueueReturnValue
    }

    //MARK: - getNext

    var getNextCallsCount = 0
    var getNextCalled: Bool {
        return getNextCallsCount > 0
    }
    var getNextReturnValue: Lecture?
    var getNextClosure: (() -> Lecture?)?

    func getNext() -> Lecture? {
        getNextCallsCount += 1
        return getNextClosure.map({ $0() }) ?? getNextReturnValue
    }

    //MARK: - startedPlayingLecture

    var startedPlayingLectureIdInCallsCount = 0
    var startedPlayingLectureIdInCalled: Bool {
        return startedPlayingLectureIdInCallsCount > 0
    }
    var startedPlayingLectureIdInReceivedArguments: (id: String, second: Int)?
    var startedPlayingLectureIdInReceivedInvocations: [(id: String, second: Int)] = []
    var startedPlayingLectureIdInClosure: ((String, Int) -> Void)?

    func startedPlayingLecture(id: String, in second: Int) {
        startedPlayingLectureIdInCallsCount += 1
        startedPlayingLectureIdInReceivedArguments = (id: id, second: second)
        startedPlayingLectureIdInReceivedInvocations.append((id: id, second: second))
        startedPlayingLectureIdInClosure?(id, second)
    }

    //MARK: - pausedLecture

    var pausedLectureIdInCallsCount = 0
    var pausedLectureIdInCalled: Bool {
        return pausedLectureIdInCallsCount > 0
    }
    var pausedLectureIdInReceivedArguments: (id: String, second: Int)?
    var pausedLectureIdInReceivedInvocations: [(id: String, second: Int)] = []
    var pausedLectureIdInClosure: ((String, Int) -> Void)?

    func pausedLecture(id: String, in second: Int) {
        pausedLectureIdInCallsCount += 1
        pausedLectureIdInReceivedArguments = (id: id, second: second)
        pausedLectureIdInReceivedInvocations.append((id: id, second: second))
        pausedLectureIdInClosure?(id, second)
    }

    //MARK: - addToQueueOnTop

    var addToQueueOnTopIdCallsCount = 0
    var addToQueueOnTopIdCalled: Bool {
        return addToQueueOnTopIdCallsCount > 0
    }
    var addToQueueOnTopIdReceivedId: String?
    var addToQueueOnTopIdReceivedInvocations: [String] = []
    var addToQueueOnTopIdClosure: ((String) -> Void)?

    func addToQueueOnTop(id: String) {
        addToQueueOnTopIdCallsCount += 1
        addToQueueOnTopIdReceivedId = id
        addToQueueOnTopIdReceivedInvocations.append(id)
        addToQueueOnTopIdClosure?(id)
    }

    //MARK: - addToQueueAtBottom

    var addToQueueAtBottomIdCallsCount = 0
    var addToQueueAtBottomIdCalled: Bool {
        return addToQueueAtBottomIdCallsCount > 0
    }
    var addToQueueAtBottomIdReceivedId: String?
    var addToQueueAtBottomIdReceivedInvocations: [String] = []
    var addToQueueAtBottomIdClosure: ((String) -> Void)?

    func addToQueueAtBottom(id: String) {
        addToQueueAtBottomIdCallsCount += 1
        addToQueueAtBottomIdReceivedId = id
        addToQueueAtBottomIdReceivedInvocations.append(id)
        addToQueueAtBottomIdClosure?(id)
    }

    //MARK: - removeFromQueue

    var removeFromQueueIdCallsCount = 0
    var removeFromQueueIdCalled: Bool {
        return removeFromQueueIdCallsCount > 0
    }
    var removeFromQueueIdReceivedId: String?
    var removeFromQueueIdReceivedInvocations: [String] = []
    var removeFromQueueIdClosure: ((String) -> Void)?

    func removeFromQueue(id: String) {
        removeFromQueueIdCallsCount += 1
        removeFromQueueIdReceivedId = id
        removeFromQueueIdReceivedInvocations.append(id)
        removeFromQueueIdClosure?(id)
    }

    //MARK: - changeOrder

    var changeOrderIdFromToCallsCount = 0
    var changeOrderIdFromToCalled: Bool {
        return changeOrderIdFromToCallsCount > 0
    }
    var changeOrderIdFromToReceivedArguments: (id: String, origin: Int, destination: Int)?
    var changeOrderIdFromToReceivedInvocations: [(id: String, origin: Int, destination: Int)] = []
    var changeOrderIdFromToClosure: ((String, Int, Int) -> Void)?

    func changeOrder(id: String, from origin: Int, to destination: Int) {
        changeOrderIdFromToCallsCount += 1
        changeOrderIdFromToReceivedArguments = (id: id, origin: origin, destination: destination)
        changeOrderIdFromToReceivedInvocations.append((id: id, origin: origin, destination: destination))
        changeOrderIdFromToClosure?(id, origin, destination)
    }

}
