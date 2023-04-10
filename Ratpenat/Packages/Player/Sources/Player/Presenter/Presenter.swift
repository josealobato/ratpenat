import SwiftUI
import struct Entities.Lecture

final class Presenter: ObservableObject, InteractorOutput {

    // View Interface
    @Published var lecture: LectureViewModel = LectureViewModel.none
    @Published var viewState: PlayerView.ViewState? = .loading

    let interactor: InteractorInput

    init(interactor: InteractorInput) {

        self.interactor = interactor
    }

    func request(_ event: InteractorEvents.Input) async {

        await interactor.request(event)
    }

    func dispatch(_ event: InteractorEvents.Output) {

        DispatchQueue.main.async {

            self.dispatchOnMain(event)
        }
    }

    private func renderContent(lecture: LectureViewModel) {

        withAnimation {

            viewState = nil
            self.lecture = lecture
        }
    }

    private func dispatchOnMain(_ event: InteractorEvents.Output) {

        switch event {
        case .startLoading:
            //            updateViewState(.loading)
            break

        case .refresh(let data):
            let lectureViewModel = createViewModel(from: data)
            renderContent(lecture: lectureViewModel)
            break
        case .noLecture:
            break
        }
    }

    private func createViewModel(from data: InteractorEvents.Output.LectureData) -> LectureViewModel {

        LectureViewModel.build(from: data)
    }
}
