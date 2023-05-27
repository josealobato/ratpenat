import Entities
import protocol RData.LecturesRepositoryIntefaceCRUD

public struct QueueManagementService {

    private let storage: LecturesRepositoryIntefaceCRUD

    public init(storage: LecturesRepositoryIntefaceCRUD) {
        self.storage = storage
    }
}

extension QueueManagementService: QueueManagementServiceProtocol {

    public func getQueue() -> [Entities.Lecture] {
        return []
    }
}
