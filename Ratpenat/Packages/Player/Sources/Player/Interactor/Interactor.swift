import Foundation

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: PlayerServiceInterface

    init(services: PlayerServiceInterface) {
        self.services = services
    }

    // MARK: - Intercator input

    func request(_ event: InteractorEvents.Input) async {

        switch event {

        case .loadInitialData:
            render(.startLoading)
            await fetchData()
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
}

private extension Interactor {

    func fetchData() async {

        do {

            let nextPlay = try await services.nextPlay()
            render(.refresh(nextPlay))
        } catch {

            renderError(error)
        }
    }
}
