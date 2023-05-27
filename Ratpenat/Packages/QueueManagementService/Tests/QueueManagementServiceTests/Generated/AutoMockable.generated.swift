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
    var lectureWithIdReturnValue: LectureDataEntity!
    var lectureWithIdClosure: ((String) throws -> LectureDataEntity)?

    func lecture(withId id: String) async throws -> LectureDataEntity {
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

}
