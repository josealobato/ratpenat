import SwiftUI

struct PlayerCompositeView: View {

    @Binding var viewModel: LectureViewModel

    @State var possition: Int = 0

    var onPlayPause: (() -> Void)
    var onForward: (() -> Void)
    var onBackwards: (() -> Void)

    var body: some View {
        VStack {
            title
            PlayControls(isPlaying: viewModel.isPlaying,
                         isEnabled: viewModel.isEnabled)
                .onPlayPause { onPlayPause() }
                .onForward { onForward() }
                .onBackwards { onBackwards() }
                .disabled(!viewModel.isEnabled)
                .blur(radius: viewModel.isEnabled ? 0 : 2)

            PositionSlider(possition: $viewModel.currentPossitionInSeconds,
                           length: viewModel.totalLenghtInSeconds)
                .disabled(!viewModel.isEnabled)
                .blur(radius: viewModel.isEnabled ? 0 : 2)
        }
    }

    private var title: some View {

        Text(viewModel.title)
            .font(.headline)
    }
}

struct PlayerCompositeView_Previews: PreviewProvider {

    @State static var model = LectureViewModel(id: "01",
                                               title: "One",
                                               isEnabled: true,
                                               isPlaying: false,
                                               totalLenghtInSeconds: 3600,
                                               currentPossitionInSeconds: 360)
    static var previews: some View {
        Group {
            PlayerCompositeView(viewModel: .constant(model),
                                onPlayPause: { },
                                onForward: { },
                                onBackwards: { })
            .previewDisplayName("PlayerComposite(Dark)")
            .preferredColorScheme(.dark)

            PlayerCompositeView(viewModel: .constant(model),
                                onPlayPause: { },
                                onForward: { },
                                onBackwards: { })
            .previewDisplayName("PlayerComposite(Light)")
            .preferredColorScheme(.light)

        }
        
    }
}
