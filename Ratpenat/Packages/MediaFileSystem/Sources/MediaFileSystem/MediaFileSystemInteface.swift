import Foundation

public protocol MediaFileSystemInteface {

    func setUpIfNeeded() async

    func managedFiles() async -> [MediaFile]
    func unmanagedFiles() async -> [MediaFile]

    func manageFile(file: MediaFile)
    func deleteFile(file: MediaFile)
    func archiveFile(file: MediaFile)
}
