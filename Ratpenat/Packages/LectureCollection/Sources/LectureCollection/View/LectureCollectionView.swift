import SwiftUI

struct LectureCollectionView: View {

    enum ViewState {

        case loading
    }

    @StateObject private var presenter: Presenter

    init(presenter: Presenter) {

        self._presenter = StateObject(wrappedValue: presenter)
    }
    
    var body: some View {
        LectureList(lectures: $presenter.lectures, onTap: { _ in })
            .navigationTitle("Lecture List")
            .onAppear { request(.loadInitialData) }

    }

    func request(_ event: InteractorEvents.Input) {

        Task {

            await presenter.request(event)
        }
    }
}

struct LectureCollectionView_Previews: PreviewProvider {

    struct TestContainer: View {

        @State private var previewLectures: [LectureViewModel] = [
            LectureViewModel(id: "01",
                             title: "Title of One"),
            LectureViewModel(id: "02",
                             title: "Title of Two")
        ]

        var body: some View {
            LectureList(lectures: $previewLectures, onTap: {_ in })
        }

    }

    static var previews: some View {
        TestContainer()
            .previewDisplayName("ContainerView")
    }
}
