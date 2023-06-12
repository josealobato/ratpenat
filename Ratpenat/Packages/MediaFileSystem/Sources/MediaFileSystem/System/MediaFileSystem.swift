import Foundation

struct MediaFileSystem {

    enum Constants {
        static let managedFolderName: String = "Managed"
        static let inboxFolderName: String = "Inbox"
        static let archivedFolderName: String = "Archived"
        static let rejectedFolderName: String = "Rejected"
    }

    init() {
       setUpIfNeeded()
    }

    private func setUpIfNeeded() {

        setUpManageFolderIfNeeded()
        setUpInboxFolderIfNeeded()
        setUpArchivedFolderIfNeeded()

        // Rejected folder is for now deactivated.
        // we could created when there is a file rejected.
        //setUpRejectedFolderIfNeeded()
    }

    let defaultMediaFilesFilesInBundle = [

            Bundle.module.url(forResource: "1-Introduction to Ratpenat 1", withExtension: "mp3")!,
            Bundle.module.url(forResource: "2-Introduction to Ratpenat 2", withExtension: "mp3")!,
            Bundle.module.url(forResource: "3-Introduction to Ratpenat 3", withExtension: "mp3")!,
        ]

    private func existDirectory(url: URL) -> Bool {

        let fm = FileManager.default
        var isDir : ObjCBool = false

        let existFile = fm.fileExists(atPath: url.path, isDirectory: &isDir)
        let isDirectory = isDir.boolValue == true

        return existFile && isDirectory
    }

    private func setUpManageFolderIfNeeded() {

        do {
            let fm = FileManager.default
            let docsURL = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            print("jal - docsURL: \(docsURL.absoluteString)")

            let manageFolderULR = docsURL.appendingPathComponent(Constants.managedFolderName)
            if !existDirectory(url: manageFolderULR) {

                try fm.createDirectory(at: manageFolderULR, withIntermediateDirectories: false)
                for mediaFileURL in defaultMediaFilesFilesInBundle {

                    let fileName = mediaFileURL.lastPathComponent
                    let newUrl = manageFolderULR.appendingPathComponent(fileName)
                    try fm.copyItem(at: mediaFileURL, to: newUrl)
                }
            }
        } catch { /* Nothing to do */ }
    }

    private func setUpInboxFolderIfNeeded() {

        do {
            let fm = FileManager.default
            let docsURL = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            print("jal - docsURL: \(docsURL.absoluteString)")

            let manageFolderULR = docsURL.appendingPathComponent(Constants.inboxFolderName)
            if !existDirectory(url: manageFolderULR) {

                try fm.createDirectory(at: manageFolderULR, withIntermediateDirectories: false)
            }
        } catch { /* Nothing to do */ }
    }

    private func setUpArchivedFolderIfNeeded() {

        do {
            let fm = FileManager.default
            let docsURL = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

            let manageFolderULR = docsURL.appendingPathComponent(Constants.archivedFolderName)
            if !existDirectory(url: manageFolderULR) {

                try fm.createDirectory(at: manageFolderULR, withIntermediateDirectories: false)
            }
        } catch { /* Nothing to do */ }
    }

    private func setUpRejectedFolderIfNeeded() {

        do {
            let fm = FileManager.default
            let docsURL = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

            let manageFolderULR = docsURL.appendingPathComponent(Constants.rejectedFolderName)
            if !existDirectory(url: manageFolderULR) {

                try fm.createDirectory(at: manageFolderULR, withIntermediateDirectories: false)
            }
        } catch { /* Nothing to do */ }
    }
}

extension MediaFileSystem: MediaFileSystemInteface {

    private func inboxFolder() throws -> URL {

        let fm = FileManager.default
        let docsURL = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return docsURL.appendingPathComponent(Constants.inboxFolderName)
    }

    private func managedFolder() throws -> URL {

        let fm = FileManager.default
        let docsURL = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return docsURL.appendingPathComponent(Constants.managedFolderName)
    }

    private func archivedFolder() throws -> URL {

        let fm = FileManager.default
        let docsURL = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return docsURL.appendingPathComponent(Constants.archivedFolderName)
    }

    private func rejectedFolder() throws -> URL {

        let fm = FileManager.default
        let docsURL = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return docsURL.appendingPathComponent(Constants.rejectedFolderName)
    }

    private func mediaFilesInFolder(folderURL: URL, isManaged: Bool) throws  -> [MediaFile] {

        let fm = FileManager.default
        let fileURLs = try fm.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)

        let mediaFiles = fileURLs.compactMap { MediaFile.init(url: $0, isNew: !isManaged) }

        return mediaFiles
    }
    
    func managedFiles() -> [MediaFile] {

        do {
            let managedFolder = try managedFolder()
            return try mediaFilesInFolder(folderURL: managedFolder, isManaged: true)
        } catch { /* Nothing to do */ }
        return []
    }

    func unmanagedFiles() -> [MediaFile] {

        do {
            let inboxFolder = try inboxFolder()
            return try mediaFilesInFolder(folderURL: inboxFolder, isManaged: false)
        } catch { /* Nothing to do */ }
        return []
    }

    func updateFile(file: MediaFile) -> MediaFile? {

        guard file.isDirty else { return file }
        guard file.canBeManaged else { return nil }

        do {
            let currentLocation = file.url
            let base = currentLocation.deletingLastPathComponent()
            let destinationLocation = base.appendingPathComponent(file.fileName)

            let fm = FileManager.default
            try fm.moveItem(at: currentLocation, to: destinationLocation)

            return MediaFile(url: destinationLocation, isNew: file.isNew)
        } catch { return nil }
    }

    func manageFile(file: MediaFile) -> MediaFile? {

        guard file.canBeManaged else { return nil }

        do {
            let currentLocation = file.url
            let destination = try managedFolder().appendingPathComponent(file.fileName)

            let fm = FileManager.default
            try fm.moveItem(at: currentLocation, to: destination)
            return MediaFile(url: destination, isNew: false)
        } catch { return nil }
    }

    func archiveFile(file: MediaFile) -> MediaFile? {

        guard file.canBeManaged else { return nil }

        do {
            let currentLocation = file.url
            let destination = try archivedFolder().appendingPathComponent(file.fileName)

            let fm = FileManager.default
            try fm.moveItem(at: currentLocation, to: destination)
            return MediaFile(url: destination, isNew: false)
        } catch { return nil }
    }

    func unarchiveFile(file: MediaFile) -> MediaFile? {

        manageFile(file: file)
    }

    func deleteFile(file: MediaFile) {

        do {
            let fm = FileManager.default
            try fm.removeItem(at: file.url)
        } catch { print("Error deleting file: \(error)") }
    }
}
