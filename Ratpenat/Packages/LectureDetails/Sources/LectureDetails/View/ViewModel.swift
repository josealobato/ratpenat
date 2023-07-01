import Foundation
import struct Entities.Lecture

struct ViewModel: Equatable {

    /// We privately save the orinal Lecture to be able to identify changes
    /// in the editor.
    private var originalLecture: Lecture?

    var title: String

    var readyToSave: Bool { originalLecture?.title != title }

    init(originalLecture: Lecture? = nil, title: String) {
        self.originalLecture = originalLecture
        self.title = title
    }
}

extension ViewModel {

    static func build(from lecture: Lecture) -> ViewModel {

        return ViewModel(
            originalLecture: lecture,
            title: lecture.title)
    }

    static func `default`() -> ViewModel {

        return ViewModel(
            originalLecture: nil,
            title: "Title")
    }
}
