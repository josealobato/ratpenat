import SwiftUI

struct PlayControls: View {

    var isPlaying: Bool

    private let buttonsize =  40.0
    private let internalPadding = 60.0
    private let height = 80.0
    private let handlers: PlayControlsHandlers = .init()

    var body: some View {

        HStack {
            Spacer()
            Button {
                backwards()
            } label: {
                Image(systemName: "backward.fill")
                    .resizable()
                    .frame(width: buttonsize, height: buttonsize)
                    .foregroundColor(.primary)
            }
            Button {
                playPause()
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: buttonsize, height: buttonsize)
                    .padding(EdgeInsets(top: 0,
                                        leading: internalPadding,
                                        bottom: 0,
                                        trailing: internalPadding))
                    .foregroundColor(.primary)
            }
            Button {
                forward()
            } label: {
                Image(systemName: "forward.fill")
                    .resizable()
                    .frame(width: buttonsize, height: buttonsize)
                    .foregroundColor(.primary)
            }
            Spacer()
        }
        .frame(height: height)
    }

    public func onPlayPause(_ action: @escaping (() -> Void)) -> Self {
        handlers.onPlayPause = action
        return self
    }

    public func onForward(_ action: @escaping (() -> Void)) -> Self {
        handlers.onForward = action
        return self
    }

    public func onBackwards(_ action: @escaping (() -> Void)) -> Self {
        handlers.onBackwards = action
        return self
    }
}

private class PlayControlsHandlers {

    var onPlayPause: (() -> Void)?
    var onBackwards: (() -> Void)?
    var onForward: (() -> Void)?
}

private extension PlayControls {

    func playPause() {
        handlers.onPlayPause?()
    }

    func backwards() {
        handlers.onBackwards?()
    }

    func forward() {
        handlers.onForward?()
    }
}

struct PlayControls_Previews: PreviewProvider {
    static var previews: some View {
        PlayControls(isPlaying: true)
    }
}
