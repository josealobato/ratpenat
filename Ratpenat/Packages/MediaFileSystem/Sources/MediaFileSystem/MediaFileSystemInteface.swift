import Foundation

public protocol MediaFileSystemInteface {

    /// Access to all the existing managed files.
    /// - Returns: a list of the existing media files
    func managedFiles() -> [MediaFile]

    /// Access to all the existing new files.
    /// - Returns: a list of the existing new files in the inbox.
    func unmanagedFiles() -> [MediaFile]

    /// Update a file with the new information.
    /// Any file can be updated independently of it location, but is should be ready
    /// to be managed which means that it show be given and id and a name.
    /// Update file won't change the location of the file just its name.
    /// - Parameter file: The file to update.
    /// - Returns: the updated file, or nil if the action could not be done.
    func updateFile(file: MediaFile) -> MediaFile?

    /// Mark a file as managed.
    /// Only a file with proper id and name can be managed.
    /// - Parameter file: The file to manage.
    /// - Returns: The new managed file.
    func manageFile(file: MediaFile) -> MediaFile?

    /// Archive a file.
    /// Only a managed file can be archived.
    /// - Parameter file: The file to archive.
    /// - Returns: The new archived file.
    func archiveFile(file: MediaFile) -> MediaFile?

    /// Unarchive the give file.
    /// An unarchive file become a managed file.
    /// - Parameter file: the file to unarchive.
    /// - Returns: the new managed file.
    func unarchiveFile(file: MediaFile) -> MediaFile?

    /// delete a file
    /// - Parameter file: file to delete.
    func deleteFile(file: MediaFile)
}
