import Foundation
import MediaFileSystem

public enum MediaManagementServiceBuilder {

    public static func build(fileSystem: MediaFileSystemInteface) -> MediaManagementServiceInterface {

        MediaManagementService(fileSystem: fileSystem)
    }
}
