import Entities
import Coordinator
import RData
import protocol RData.LecturesRepositoryIntefaceCRUD

public class QueueManagementService {

    private let storage: LecturesRepositoryIntefaceCRUD

    private var queue: [Lecture] = []

    public weak var coordinator: CoordinationRequestProtocol?

    public init(storage: LecturesRepositoryIntefaceCRUD) {
        self.storage = storage
    }
}

extension QueueManagementService: QueueManagementServiceProtocol {

    // MARK: - Getting lectures from the queue.
    
    public func getQueue() -> [Entities.Lecture] {
        return queue
    }

    public func getNext() -> Entities.Lecture? {

        return queue.count > 0 ? queue[0] : nil
    }

    // MARK: - Playing

    public func startedPlayingLecture(id: String, in second: Int) { Task { startedPlayingLecture(id:id, in:second) } }

    func startedPlayingLecture(id: String, in second: Int) async {

        // if the object is not in the queue do nothing.
        guard isLectureInQueue(id: id) else { return }

        do {

            // if the lecture is not the first we sort it first.
            if let playingIndex = queue.firstIndex(where: { $0.id == id }) {
                if playingIndex != 0 {
                    await changeOrder(id: id, from: playingIndex, to: 0)
                }
            }

            // Set the play position.
            queue[0].playPosition = second

            // TODO: Notify externally about new playing lecture

            // Persist
            try await storage.update(lecture: queue[0].dataEntity())
            
        } catch {
            // TODO: log this error.
        }
    }

    // MARK: - Adding and Removing

    public func addToQueueOnTop(id: String) { Task { addToQueueOnTop(id: id) } }

    func addToQueueOnTop(id: String) async {

        // if the object is already there do nothing.
        guard !isLectureInQueue(id: id) else { return }

        // get the object from the store.
        if let dataLecture = try? await storage.lecture(withId: id) {

            // add to the queue.
            queue.insert(dataLecture.entity(), at: 0)

            // adjust the indexes.
            consolidateIndexInQueue()
            await persistQueue()
        }
    }

    public func addToQueueAtBottom(id: String)  { Task { addToQueueOnTop(id: id) } }

    func addToQueueAtBottom(id: String) async {

        // if the object is already there do nothing.
        guard !isLectureInQueue(id: id) else { return }

        // get the object from the store.
        if let dataLecture = try? await storage.lecture(withId: id) {

            // add to the queue.
            queue.append(dataLecture.entity())

            // adjust the indexes and store
            consolidateIndexInQueue()
            await persistQueue()
        }
    }

    public func removeFromQueue(id: String)  { Task { removeFromQueue(id: id) } }

    func removeFromQueue(id: String) async {

        // if the object is not in queue do nothing.
        guard isLectureInQueue(id: id) else { return }

        if let index = queue.firstIndex(where: { $0.id == id }) {

            // Remove the object
            queue.remove(at: index)

            // adjust the indexes and store
            consolidateIndexInQueue()
            await persistQueue()
        }
    }

    // MARK: - Sorting

    public func changeOrder(id: String, from origin: Int, to destination: Int) {
        Task { await changeOrder(id: id, from: origin, to: destination) }
    }

    func changeOrder(id: String, from origin: Int, to destination: Int) async {

        // Index should be valid
        guard isIndexInRange(index: origin) && isIndexInRange(index: destination)
          else { return }

        // ... and different.
        guard origin != destination else { return }


        if (origin < destination) {

            let lecture = queue[origin]
            queue.remove(at: origin)
            queue.insert(lecture, at: destination - 1)

        } else {

            let lecture = queue[origin]
            queue.remove(at: origin)
            queue.insert(lecture, at: destination)
        }

        consolidateIndexInQueue()
        await persistQueue()
    }

    /// Update the Queue possition of the current state of the queue,
    /// making sure that they represent the current possition on the queue.
    private func consolidateIndexInQueue() {

        for i in 0..<queue.count {

            queue[i].queuePosition = i + 1
        }
    }

    /// Persiste the current state of the queue to the storage.
    private func persistQueue() async {

        do {
            for lecture in queue {
                try await storage.update(lecture: lecture.dataEntity())
            }
        } catch {
            // TODO: log error
        }
    }

    /// Verifies that the given index is inside the boudaries of the queue
    /// - Parameter index: The index to test.
    /// - Returns: True when it is a valid index (in range)
    private func isIndexInRange(index: Int) -> Bool {

        let range = 0 ..< queue.count
        return range.contains(index)
    }

    /// Check if exist in the queue a lecture with the given id.
    /// - Parameter id: the id to look for.
    /// - Returns: true if there exist a lecture with the given id.
    private func isLectureInQueue(id: String) -> Bool {
        queue.first(where: { $0.id == id }) != nil
    }
}

extension QueueManagementService: CoordinatorServiceLifeCycleProtocol {

    public func start() {

        Task {
            await start()
        }
    }

    func start() async {

        do {
            let dataLectures = try await storage.lectures()
            let dataLecturesOnQueue = dataLectures.filter { $0.queuePosition != nil }
            let lectures = dataLecturesOnQueue.map { $0.entity() }
            let sortedLectures = lectures.sorted { lhLecture, rhLecture in

                // Notice that the possition could be null.
                // But, that won't happen becuase they have already been filtered.
                if let lhPosition = lhLecture.queuePosition,
                    let rhPosition = rhLecture.queuePosition {
                    return lhPosition < rhPosition
                } else { return false }
            }
            queue.append(contentsOf: sortedLectures)
        } catch {
            // TODO: Log error
            print(error)
        }

    }

    public func stop() { /* Nothing to do */ }
}

