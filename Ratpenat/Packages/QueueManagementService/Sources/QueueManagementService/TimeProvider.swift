import Foundation

/// We need a time stamp to use when DONE playing a lesson.
/// The TimeProvider Protocol allows us to abstract this method and inject a
/// comvenient mock for testing.

protocol TimeProvider {

    var now: Date { get }
}

/// LocalTimeProvider will be the TimerProvider use by default on the QMS.
struct LocalTimeProvider: TimeProvider {

    var now: Date  {
         Date()
    }
}
