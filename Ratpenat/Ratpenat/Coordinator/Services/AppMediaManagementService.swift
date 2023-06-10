import Foundation
import Coordinator
import MediaManagementService
import MediaFileSystem

class AppMediaManagementService: CoordinatorServiceLifeCycleProtocol {

    var service: MediaManagementServiceInterface

    init(fileSystem: MediaFileSystemInteface) {

        self.service = MediaManagementServiceBuilder.build(fileSystem: fileSystem)
    }

    var coordinator: Coordinator.CoordinationRequestProtocol?

    func start() {
        service.startManaging()
    }

    func stop() {
        service.stopManaging()
    }
}
