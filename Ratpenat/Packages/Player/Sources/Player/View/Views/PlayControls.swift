import SwiftUI

struct PlayControls: View {

    let buttonsize =  40.0
    let internalPadding = 60.0
    let height = 80.0

    var isPlaying: Bool
    var onPlayPause: (() -> Void)
    var onForward: (() -> Void)
    var onBackwards: (() -> Void)

    var body: some View {

        HStack {
            Spacer()
            Button {
                onBackwards()
            } label: {
                Image(systemName: "backward.fill")
                    .resizable()
                    .frame(width: buttonsize, height: buttonsize)
                    .foregroundColor(.white)
            }
            Button {
                onPlayPause()
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: buttonsize, height: buttonsize)
                    .padding(EdgeInsets(top: 0,
                                        leading: internalPadding,
                                        bottom: 0,
                                        trailing: internalPadding))
                    .foregroundColor(.white)
            }
            Button {
                onForward()
            } label: {
                Image(systemName: "forward.fill")
                    .resizable()
                    .frame(width: buttonsize, height: buttonsize)
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .frame(height: height)
    }
}

struct PlayControls_Previews: PreviewProvider {
    static var previews: some View {
        PlayControls(isPlaying: false,
                     onPlayPause: { },
                     onForward: { },
                     onBackwards: { })
            .background(.black)
    }
}
