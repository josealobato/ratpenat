import Foundation

/// For convenience I use a protocol here.
/// This may cause issues if Equatable or Identifiable is needed
/// as any moment (any), but since it is not needed yet It simplyfy things.
public protocol PlayerLecture {

    var id: String { get }
    var title: String { get }
    var mediaURL: URL { get }
}
