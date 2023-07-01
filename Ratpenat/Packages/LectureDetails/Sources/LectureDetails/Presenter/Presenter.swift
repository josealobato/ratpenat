import SwiftUI
import struct Entities.Lecture

final class Presenter: ObservableObject, InteractorOutput {

    // View Interface
    @Published var lecture: ViewModel = ViewModel.default()
    @Published var viewState: PackageView.ViewState? = .loading

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

    private func renderContent(lecture: ViewModel) {

        withAnimation {

            viewState = nil
            self.lecture = lecture
        }
    }

    private func dispatchOnMain(_ event: InteractorEvents.Output) {

        switch event {
        case .startLoading:
            //updateViewState(.loading)
            break

        case .refresh(let lecture):
            let viewModel = createViewModel(from: lecture)
            renderContent(lecture: viewModel)
            break
        }
    }

    private func createViewModel(from entity: Lecture) -> ViewModel {

        ViewModel.build(from: entity)
    }
}
