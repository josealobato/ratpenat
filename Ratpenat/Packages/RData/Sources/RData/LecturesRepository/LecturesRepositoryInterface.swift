import Foundation

public protocol LecturesRepositoryInteface {

    /// The collection of all existing lectures.
    /// - Returns: An Array with all exiting lectures.
    func lectures() async throws -> [LectureDataEntity]
}
