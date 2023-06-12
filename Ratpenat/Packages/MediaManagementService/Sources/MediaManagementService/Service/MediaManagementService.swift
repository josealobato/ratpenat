import Foundation
import MediaFileSystem

struct MediaManagementService {

    private let fileSystem: MediaFileSystemInteface

    init(fileSystem: MediaFileSystemInteface) {

        self.fileSystem = fileSystem
    }
}

extension MediaManagementService: MediaManagementServiceInterface {

    func startManaging() {

        Task {
            // Only after the file system is ready we can start processing files.
            await checkUnmanaged()
        }
    }

    func stopManaging() { /* Nothing to do */ }
}

extension MediaManagementService {

    func checkUnmanaged() async {

    }
}
