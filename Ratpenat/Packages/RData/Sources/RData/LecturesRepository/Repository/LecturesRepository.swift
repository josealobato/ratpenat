import Foundation

class LecturesRepository {

    // This is the inteface to act upon the storage.
    // Mostly save and load.
    var storage: StorageInterface

    // This is the local copy of the storage.
    var storageData: StorageData

    init(storage: StorageInterface) {

        self.storage = storage
        self.storageData = storage.data()
    }
}
