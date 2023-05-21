import SwiftUI
import struct Entities.Lecture

final class Presenter: ObservableObject, InteractorOutput {

    // View Interface
    @Published var lectures: [LectureViewModel] = []
    @Published var viewState: QueueCollectionView.ViewState? = .loading

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

    private func renderContent(lectures: [LectureViewModel]) {

        withAnimation {

            viewState = nil
            self.lectures = lectures
        }
    }

    private func dispatchOnMain(_ event: InteractorEvents.Output) {

        switch event {
        case .startLoading:
            //            updateViewState(.loading)
            break

        case .refresh(let lectures):
            let lectureViewModels = lectures.compactMap(createViewModel)
            renderContent(lectures: lectureViewModels)
            break
        }
    }

    private func createViewModel(from entity: Lecture) -> LectureViewModel {

        LectureViewModel.build(from: entity)
    }
}
