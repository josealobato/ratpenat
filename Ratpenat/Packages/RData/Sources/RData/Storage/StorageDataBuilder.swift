import Foundation

/// It takes care of creating the `Metadata` folder and copying the default JSON
/// file if needed. Otherwise it will return the one that is already there.
/// To use it just call `build()`.
class StorageDataBuilder: StorageInterface {

    private enum Constants {
        static let metadataFolderName: String = "Metadata"
    }

    private let defaultStorageURL = Bundle.module.url(forResource: "StorageData", withExtension: "json")!

    private func existDirectory(url: URL) -> Bool {

        let fm = FileManager.default
        var isDir : ObjCBool = false

        let existFile = fm.fileExists(atPath: url.path, isDirectory: &isDir)
        let isDirectory = isDir.boolValue == true

        return existFile && isDirectory
    }

    private func setUpMetadataFolderIfNeeded() {

        do {
            let fm = FileManager.default
            let docsURL = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

            let folderULR = docsURL.appendingPathComponent(Constants.metadataFolderName)
            if !existDirectory(url: folderULR) {

                try fm.createDirectory(at: folderULR, withIntermediateDirectories: false)
                let fileName = defaultStorageURL.lastPathComponent
                let newUrl = folderULR.appendingPathComponent(fileName)
                try fm.copyItem(at: defaultStorageURL, to: newUrl)
            }
        } catch { /* Nothing to do */ }
    }

    private func loadStorage() -> StorageData {

        let fm = FileManager.default

        do {
            let docsURL = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let folderULR = docsURL.appendingPathComponent(Constants.metadataFolderName)
            let fileName = defaultStorageURL.lastPathComponent
            let storageURL = folderULR.appendingPathComponent(fileName)

            let data = try Data(contentsOf: storageURL)
            let decoder = JSONDecoder()
            let decoded =  try decoder.decode(StorageData.self, from: data)
            print(decoded)
            return decoded
        } catch {
            print("Error!! Unable to parse the storage")
            return StorageData(lectures: [], categories: [])
        }
    }

    private func saveStorage(data: StorageData) {

        let fm = FileManager.default

        do {
            let docsURL = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let folderULR = docsURL.appendingPathComponent(Constants.metadataFolderName)
            let fileName = defaultStorageURL.lastPathComponent
            let storageURL = folderULR.appendingPathComponent(fileName)

            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: storageURL)

        } catch {
            print("Error!! Unable to encode the storage")
        }
    }

    // MARK: - StorageInterface protocol

    /// Get the current Data storage.
    /// When none exit you will get the default storage.
    /// - Returns: A populated data storage.
    func data() -> StorageData {

        setUpMetadataFolderIfNeeded()
        return loadStorage()
    }

    func flush(data: StorageData) {

        setUpMetadataFolderIfNeeded()
        saveStorage(data: data)
    }
}
