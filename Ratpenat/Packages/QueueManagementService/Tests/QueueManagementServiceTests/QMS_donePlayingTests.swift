import XCTest
import Entities
import RData
@testable import QueueManagementService

final class QMS_donePlayingTests: XCTestCase {

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


    // MARK: - Lesson not in queue

    func testNothinHappenWhenNotInQueue_QMS0110() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures, where none is playing
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qms_ut.start()

        // WHEN informing about a lecture being done not in the list
        await qms_ut.donePlayingLecture(id: uuidString("6"))

        // THEN No lecture is playing (nothing happen)
        let lectures = qms_ut.getQueue()
        XCTAssertEqual(lectures, initialUnchangedLectures)
    }

    // MARK: - Lesson in queue

    func testDoneLectureInQueueIsRemoved_QMS0111() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qms_ut.start()

        // WHEN informing about lecture in queue done
        await qms_ut.donePlayingLecture(id: uuidString("1"))

        // THEN The lecture is removed...
        let lectures = qms_ut.getQueue()
        XCTAssert(lectures.count == 2)
        // and the queue resorted
        XCTAssert(lectures[0].id == uuidString("2"))
        XCTAssert(lectures[0].queuePosition == 1)
        XCTAssert(lectures[1].id == uuidString("3"))
        XCTAssert(lectures[1].queuePosition == 2)
    }

    func testDoneLectureInQueueMarkedAsDone_QMS0111_QMS0112() async throws {
        
        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock, timeProvider: timeProviderMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qms_ut.start()
        
        // WHEN informing about lecture in queue done
        await qms_ut.donePlayingLecture(id: uuidString("1"))

        // THEN The lecture marked as played, not playing, not in queue and saved.
        let savedLecture = LectureDataEntity(id: uuid("1"),
                                             title: "title 01",
                                             mediaURL: URL(string: "https://whatsup.com")!,
                                             queuePosition: nil,
                                             playPosition: nil,
                                             played:  [timeProviderMock.now])
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(savedLecture))
    }

    func testDoneLectureWithPlayedTimeGetAddedNewTime_QMS0111_QMS0112() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock, timeProvider: timeProviderMock)
        //       prepare storage for inital lectures with played time
        storageMock.lecturesReturnValue = initialDataLecturesWithPlayedTime
        //       start the service:
        await qms_ut.start()

        // WHEN informing about lecture in queue done
        await qms_ut.donePlayingLecture(id: uuidString("1"))

        // THEN The lecture marked as played, not playing, not in queue and saved.
        let savedLecture = LectureDataEntity(id: uuid("1"),
                                             title: "title 01",
                                             mediaURL: URL(string: "https://whatsup.com")!,
                                             queuePosition: nil,
                                             playPosition: nil,
                                             played:  [timeProviderMock.now, timeProviderMock.now])
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        XCTAssert(storeInvocations.contains(savedLecture))
    }

    func testDoneLectureInQueueMarkedAsDoneNewQueIsPersisted_QMS0112() async throws {

        // GIVEN a QMS started with an queue:
        qms_ut = QueueManagementService(storage: storageMock)
        //       prepare storage for inital lectures
        storageMock.lecturesReturnValue = initialDataLectures
        //       start the service:
        await qms_ut.start()

        // WHEN informing about lecture in queue done
        await qms_ut.donePlayingLecture(id: uuidString("1"))

        // THEN New status of the queue is stored
        let storeInvocations = storageMock.updateLectureReceivedInvocations
        for dataEntity in finalDataLectures {
            XCTAssert(storeInvocations.contains(dataEntity))
        }
    }


    // MARK: - Testing assets

    private var initialDataLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: 10),
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3, playPosition: nil)
        ]
    }

    private var initialDataLecturesWithPlayedTime: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: 10, played: [timeProviderMock.now]),
        ]
    }

    private var finalDataLectures: [LectureDataEntity] {
        [
            LectureDataEntity(id: uuid("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: nil),
            LectureDataEntity(id: uuid("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2, playPosition: nil)
        ]
    }

    private var initialUnchangedLectures: [Lecture] {
        [
            Lecture(id: uuidString("1"), title: "title 01", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 1, playPosition: 10),
            Lecture(id: uuidString("2"), title: "title 02", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 2),
            Lecture(id: uuidString("3"), title: "title 03", mediaURL: URL(string: "https://whatsup.com")!, queuePosition: 3)
        ]
    }
}
