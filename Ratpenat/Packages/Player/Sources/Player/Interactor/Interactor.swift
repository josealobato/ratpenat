import Foundation
import struct Entities.Lecture

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: PlayerServiceInterface
    let audioEngineBuider: AudioEngineInterfaceBuilder

    init(services: PlayerServiceInterface,
         audioEntineBuider: AudioEngineInterfaceBuilder) {

        self.services = services
        self.audioEngineBuider = audioEntineBuider
    }

    // MARK: - Intercator input

    func request(_ event: InteractorEvents.Input) async {

        switch event {

        case .loadInitialData:
            await loadNextLecture()
        case .playToggle:
            currentEngine?.playToggle()
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
    
    var currentLecture: Lecture?
    var currentEngine: AudioEngineInterface?

    func loadNextLecture() async {

        render(.startLoading)

        do {
            guard let lecture = try await services.nextLecture()
            else {
                render(.noLecture)
                return
            }

            let audioEngine = try audioEngineBuider.build(with: lecture.location)

            let data = InteractorEvents.Output.LectureData(lecture: lecture,
                                                           audio: audioEngine.info())
            render(.refresh(data))

            currentLecture = lecture
            currentEngine = audioEngine

        } catch {

            renderError(error)
        }

    }
}

private extension Interactor {

}
