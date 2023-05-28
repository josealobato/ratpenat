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

    // MARK: - Adding and Removing

    private func isLectureInQueue(id: String) -> Bool {
        queue.first(where: { $0.id == id }) != nil
    }

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
            await saveQueue()
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
            await saveQueue()
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
            await saveQueue()
        }
    }

    // MARK: - Sorting

    public func changeOrder(id: String, from origin: Int, to destination: Int) {

        Task {
            await changeOrder(id: id, from: origin, to: destination)
        }
    }

    func changeOrder(id: String, from origin: Int, to destination: Int) async {

        // Index should be valid
        guard isIndexValid(index: origin) && isIndexValid(index: destination)
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
        await saveQueue()
    }

    private func consolidateIndexInQueue() {

        for i in 0..<queue.count {

            queue[i].queuePosition = i + 1
        }
    }

    private func saveQueue() async {

        do {
            for lecture in queue {
                try await storage.update(lecture: lecture.dataEntity())
            }
        } catch {
            // TODO log error
        }
    }

    private func isIndexValid(index: Int) -> Bool {

        let range = 0 ..< queue.count
        return range.contains(index)
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

