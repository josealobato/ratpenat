import Foundation
import struct Entities.Lecture

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: PlayerServiceInterface
    let audioEngineBuider: AudioEngineInterfaceBuilder

    init(services: PlayerServiceInterface,
         audioEngineBuider: AudioEngineInterfaceBuilder) {

        self.services = services
        self.audioEngineBuider = audioEngineBuider
    }

    // MARK: - Intercator input

    func request(_ event: InteractorEvents.Input) async {

        print("jal - INTERACTOR Request (\(event))")
        switch event {

        case .loadInitialData:
            await loadNextLecture()
        case .playToggle:
            await onPlayPause()
        case .skipForward:
            onSkipForwards()
        case .skipBackwards:
            onSkipBackwards()
        }
    }

    // MARK: - Intercator output

    func render(_ event: InteractorEvents.Output) {

        DispatchQueue.main.async {

            self.output?.dispatch(event)
        }
    }

    // MARK: - Error

    private func renderError(_ error: Error, retryAction: (() -> Void)? = nil) {
        // Work with interactor and the SnackBar.
    }

    // MARK: - Action
    
    private var currentLecture: Lecture?
    private var currentEngine: AudioEngineInterface?

    private func loadNextLecture() async {

        render(.startLoading)

        do {
            guard let lecture = try await services.nextLecture()
            else {
                render(.noLecture)
                return
            }


            let audioEngine = try audioEngineBuider.build(with: lecture.location,
                                                          onPlaybackRefresh: enginePlaybackUpdate)

            let data = InteractorEvents.Output.LectureData(lecture: lecture,
                                                           audio: audioEngine.info())
            render(.refresh(data))

            currentLecture = lecture
            currentEngine = audioEngine

        } catch {

            renderError(error)
        }
    }

    func enginePlaybackUpdate(audioInfo: AudioInfo) {

        guard let lecture = currentLecture
        else { return }

        let data = InteractorEvents.Output.LectureData(lecture: lecture,
                                                       audio: audioInfo)
        render(.refresh(data))
    }

    private func onPlayPause() async {

        guard let engine = currentEngine,
              let lecture = currentLecture
        else { return }

        engine.playToggle()
        let data = InteractorEvents.Output.LectureData(lecture: lecture,
                                                       audio: engine.info())
        render(.refresh(data))
    }

    private func onSkipForwards() {

        currentEngine?.seek(to: 10)
    }

    private func onSkipBackwards() {

        currentEngine?.seek(to: -10)
    }
}

private extension Interactor {

}
