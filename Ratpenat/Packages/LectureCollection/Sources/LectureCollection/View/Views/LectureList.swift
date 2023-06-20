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
                           imageName: lecture.imageName,
                           isStacked: lecture.isStacked,
                           timesPlayed: lecture.timesPlayed)
                .onPlay { play(id: lecture.id) }
                .onEnqueue { enqueue(id: lecture.id) }
                .onDequeue { dequeue(id: lecture.id) }
                .onDelete { delete(id: lecture.id) }
                .onTapGesture { select(id: lecture.id) }
            }
            .listRowSeparator(.hidden)

        }
        .listStyle(.plain)
        .navigationTitle(LocalizationKey.lectures.localize())
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

    public func onDequeue(_ action: @escaping ((String) -> Void)) -> Self {
        handlers.onDequeue = action
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
    var onDequeue: ((String) -> Void)?
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

    func dequeue(id: String) {
        handlers.onDequeue?(id)
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
                         timesPlayed: 25,
                         imageName: "book.circle",
                         isStacked: true),
        LectureViewModel(id: "02",
                         title: "This is a somehow very long title to see how it behaves",
                         subtitle: "This is a somehow very long title to see how it behaves This is a somehow very long title to see how it behaves This is a somehow very long title to see how it behaves",
                         timesPlayed: 0,
                         imageName: "book.fill",
                         isStacked: false),
        LectureViewModel(id: "03",
                         title: "Three",
                         subtitle: "",
                         timesPlayed: 0,
                         imageName: "bookmark",
                         isStacked: true),
    ]
    static var previews: some View {
        NavigationView {
            LectureList(lectures: models,
                        onTap: { _ in })
            .previewDisplayName("Lecture Collection")
            //                .preferredColorScheme(.dark)
        }

    }
}
