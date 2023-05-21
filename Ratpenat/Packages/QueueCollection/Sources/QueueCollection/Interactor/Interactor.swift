import Foundation

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: QueueCollectionServiceInterface

    init(services: QueueCollectionServiceInterface) {
        self.services = services
    }

    // MARK: - Intercator input

    func request(_ event: InteractorEvents.Input) async {

        switch event {

        case .loadInitialData: await fetchData()
        case .select(_): print("Interactor select")
        case .play(_): print("Interactor play")
        case let .dequeue(id): await dequeueLecture(withId: id)
        case .delete(_): print("Interactor delete")
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

    // MARK: - On actions

    private func dequeueLecture(withId id: String) async {

        do {
            try await services.dequeueLecture(id: id)
            await fetchData()
        } catch {

            renderError(error)
        }
    }
}

private extension Interactor {

    func fetchData() async {

        render(.startLoading)

        do {

            let lectures = try await services.queuedLectures()
            render(.refresh(lectures))
        } catch {

            renderError(error)
        }
    }
}
