import Foundation

/// Storage data is the on memory representation of all
/// the storage data.
///
/// **Rationale** At this point in the implementation a JSON
/// will all the information suffices. When needed we could go
/// to a more powerful storage.
struct StorageData: Codable {
    
    var lectures: [LectureDataEntity]
}
