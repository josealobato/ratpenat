import XCTest
import Entities
import RData
@testable import QueueManagementService

final class QMS_playRequestTests: XCTestCase {

    struct TimeProviderMock: TimeProvider {

        var now = Date()
    }

    var qms_ut: QueueManagementService!
    var storageMock: LecturesRepositoryIntefaceCRUDMock!
    var timeProviderMock: TimeProviderMock!

    override func setUp() async throws {

        storageMock = LecturesRepositoryIntefaceCRUDMock()
        timeProviderMock = TimeProviderMock()
    }

    // MARK: - Lesson in queue

    func testPlayALessonInTheQueue_QMS0120() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to play a lecture existing in the queue
        await qms_ut.playLecture(id: uuidString("2"))

        // THEN the lecture will be set at the top and persisted.
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        for dataEntity in finalDataLecturesForExistingLecture {
            XCTAssert(storeInvocations.contains(dataEntity))
        }
    }

    // MARK: - Lesson not in queue

    func testPlayALessonNotInTheQueue_QMS0121() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       prepare storage for the lecture not in queue
        storageMock.lectureWithIdReturnValue = LectureDataEntity(id: uuid("6"), title: "title 6", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: nil, playPosition: nil)
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to play a lecture none existing in the queue
        await qms_ut.playLecture(id: uuidString("6"))

        // THEN the lecture will be set at the top and persisted.
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        for dataEntity in finalDataLecturesForNoneExistingLecture {
            XCTAssert(storeInvocations.contains(dataEntity))
        }
    }

    func testPlayALessonNotInTheQueueButNotExisting_QMS0121() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       prepare storage for the lecture not in queue
        storageMock.lectureWithIdReturnValue = nil
        //       start the service:
        await qms_ut.start()

        // WHEN requesting to play a lecture non existing at all.
        await qms_ut.playLecture(id: "6")

        // THEN nothing will happen.
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.isEmpty)
        XCTAssert(qms_ut.getQueue().count == 3)
    }


    // MARK: - Testing assets

    private var initialDataLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: nil),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3, playPosition: nil)
        ]
    }

    private var finalDataLecturesForExistingLecture: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: nil),
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3, playPosition: nil)
        ]
    }

    private var finalDataLecturesForNoneExistingLecture: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("6"), title: "title 6", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: nil),
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2, playPosition: nil),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 4, playPosition: nil)
        ]
    }
}
