import Foundation
import RData
import QueueManagementService

struct AppQueueManagementService {

    // The app will have a single QueueManagementService.
    static var sharedService: QueueManagementService = QueueManagementService(storage: LecturesRepositoryBuilder.shared)
}
