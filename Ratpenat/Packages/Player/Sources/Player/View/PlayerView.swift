import SwiftUI

struct PlayerView: View {

    enum ViewState {

        case loading
    }

    @StateObject private var presenter: Presenter

    init(presenter: Presenter) {

        self._presenter = StateObject(wrappedValue: presenter)
    }
    
    var body: some View {

        VStack {
            Spacer()
            PlayerCompositeView(lecture: $presenter.lecture)
                .padding()
                .preferredColorScheme(.dark)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {

    struct TestContainer: View {

        @State private var previewLecture: LectureViewModel? = LectureViewModel(id: "01",
                                                                                title: "Title of One with some extra text for more space")

        var body: some View {
            VStack {
                Spacer()
                PlayerCompositeView(lecture: $previewLecture)
                    .padding()
                    .preferredColorScheme(.dark)
            }
        }
    }

    static var previews: some View {
        TestContainer()
            .previewDisplayName("ContainerView")
    }
}
