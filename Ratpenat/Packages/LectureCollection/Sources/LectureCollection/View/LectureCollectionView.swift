import SwiftUI

struct LectureCollectionView: View {

    enum ViewState {

        case loading
    }

    @StateObject private var presenter: Presenter
    let interactor: InteractorInput

    init(presenter: Presenter,
         interactor: InteractorInput) {

        self._presenter = StateObject(wrappedValue: presenter)
        self.interactor = interactor
    }
    
    var body: some View {
        LectureList(lectures: presenter.lectures, onTap: { _ in })
            .onSelect { request(.select($0)) }
            .onPlay {  request(.play($0)) }
            .onEnqueue { request(.enqueue($0)) }
            .onDequeue { request(.dequeue($0)) }
            .onDelete { request(.delete($0)) }
            .navigationTitle("Lecture List")
            .onAppear { request(.loadInitialData) }
    }

    func request(_ event: InteractorEvents.Input) {

        Task {

            await interactor.request(event)
        }
    }
}

struct LectureCollectionView_Previews: PreviewProvider {

    struct TestContainer: View {

        @State private var previewLectures: [LectureViewModel] = [
            LectureViewModel(id: "01",
                             title: "One",
                             subtitle: "",
                             imageName: "book.circle",
                            isStacked: true),
            LectureViewModel(id: "02",
                             title: "Two",
                             subtitle: "",
                             imageName: "book.fill",
                             isStacked: true),
            LectureViewModel(id: "03",
                             title: "Three",
                             subtitle: "",
                             imageName: "bookmark",
                             isStacked: false),
        ]
        
        var body: some View {
            LectureList(lectures: previewLectures, onTap: {_ in })
        }

    }

    static var previews: some View {
        TestContainer()
            .previewDisplayName("ContainerView")
    }
}
