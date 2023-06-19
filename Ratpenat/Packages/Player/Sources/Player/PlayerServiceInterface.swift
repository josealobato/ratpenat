import Foundation
import JToolKit
import struct Entities.Lecture

public protocol PlayerServiceInterface: AutoMockable {

    // MARK: - Requests

    /// Get the existing lectures if any
    func nextLecture() async throws -> PlayerLecture?

    // MARK: - Information

    /// Started playing media.
    /// - Parameters:
    ///   - id: The id of the media
    ///   - second: the second at the moment of start. `0` when it is at the beginning.
    func playing(id: String, in second: Int) async

    /// Paused playing media.
    /// - Parameters:
    ///   - id: The id of the media
    ///   - second: the second at the moment of pause.
    func paused(id: String, in second: Int) async

    /// skipped media.
    /// - Parameters:
    ///   - id: The id of the media
    ///   - second: the second at the moment of skipt request.
    func skipped(id: String, in second: Int) async

    /// Inform that it finishes completly playing a file.
    /// - Parameter id: the id of the media finished.
    func donePlaying(id: String) async throws
}
