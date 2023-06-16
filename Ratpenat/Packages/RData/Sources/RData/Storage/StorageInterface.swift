import Foundation

protocol StorageInterface {

    func data() -> StorageData
    func flush(data: StorageData)
}
