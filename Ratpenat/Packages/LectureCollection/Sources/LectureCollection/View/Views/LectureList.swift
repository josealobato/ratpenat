import SwiftUI

struct LectureList: View {

    var lectures: [LectureViewModel]

    var onTap: ((LectureViewModel.ID) -> Void)

    @State private var selectedTab: Int = 1
    private let handlers: ActionHandlers = .init()

    var body: some View {

        List {

            ForEach(lectures) { lecture in
                LectureRow(title: lecture.title,
                           subTitle: lecture.subtitle,
                           imageName: lecture.imageName)
                .onPlay { play(id: lecture.id) }
                .onEnqueue { enqueue(id: lecture.id) }
                .onDelete { delete(id: lecture.id) }
                .onTapGesture { select(id: lecture.id) }
            }
            .listRowSeparator(.hidden)

        }
        .listStyle(.plain)
    }

    // MARK: - Actions

    public func onSelect(_ action: @escaping ((String) -> Void)) -> Self {
        handlers.onSelect = action
        return self
    }

    public func onPlay(_ action: @escaping ((String) -> Void)) -> Self {
        handlers.onPlay = action
        return self
    }

    public func onEnqueue(_ action: @escaping ((String) -> Void)) -> Self {
        handlers.onEnqueue = action
        return self
    }

    public func onDelete(_ action: @escaping ((String) -> Void)) -> Self {
        handlers.onDelete = action
        return self
    }
}

private class ActionHandlers {

    var onSelect: ((String) -> Void)?
    var onPlay: ((String) -> Void)?
    var onEnqueue: ((String) -> Void)?
    var onDelete: ((String) -> Void)?
}

private extension LectureList {

    func select(id: String) {
        handlers.onSelect?(id)
    }

    func play(id: String) {
        handlers.onPlay?(id)
    }

    func enqueue(id: String) {
        handlers.onEnqueue?(id)
    }

    func delete(id: String) {
        handlers.onDelete?(id)
    }
}

struct SwiftUIView_Previews: PreviewProvider {

    @State static var models = [
        LectureViewModel(id: "01",
                         title: "This a normal title",
                         subtitle: "",
                         imageName: "book.circle"),
        LectureViewModel(id: "02",
                         title: "This is a somehow very long title to see how it behaves",
                         subtitle: "This is a somehow very long title to see how it behaves This is a somehow very long title to see how it behaves This is a somehow very long title to see how it behaves",
                         imageName: "book.fill"),
        LectureViewModel(id: "03",
                         title: "Three",
                         subtitle: "",
                         imageName: "bookmark"),
    ]
    static var previews: some View {
        LectureList(lectures: models,
                    onTap: { _ in })
        .previewDisplayName("Lecture Collection")
//                .preferredColorScheme(.dark)

    }
}
