import SwiftUI

struct PlayerCompositeView: View {

    @Binding var lecture: LectureViewModel

    @State var possition: Int = 0

    var onPlayPause: (() -> Void)
    var onForward: (() -> Void)
    var onBackwards: (() -> Void)

    var body: some View {
        VStack {
            title
            PlayControls(isPlaying: lecture.isPlaying)
                .onPlayPause { onPlayPause() }
                .onForward { onForward() }
                .onBackwards { onBackwards() }
            PositionSlider(possition: $possition, length: 100)
        }
    }

    private var title: some View {

        Text(lecture.title)
            .font(.headline)
    }
}

struct PlayerCompositeView_Previews: PreviewProvider {

    @State static var model = LectureViewModel(id: "01",
                                               title: "One",
                                               isPlaying: false)
    static var previews: some View {
        Group {
            PlayerCompositeView(lecture: .constant(model),
                                onPlayPause: { },
                                onForward: { },
                                onBackwards: { })
            .previewDisplayName("PlayerComposite(Dark)")
            .preferredColorScheme(.dark)

            PlayerCompositeView(lecture: .constant(model),
                                onPlayPause: { },
                                onForward: { },
                                onBackwards: { })
            .previewDisplayName("PlayerComposite(Light)")
            .preferredColorScheme(.light)

        }
        
    }
}
