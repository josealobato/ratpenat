import Foundation

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: LectureCollectionServiceInterface

    init(services: LectureCollectionServiceInterface) {
        self.services = services
    }

    // MARK: - Intercator input

    func request(_ event: InteractorEvents.Input) async {

        switch event {

        case .loadInitialData: await fetchData()
        case .select(_): print("Interactor select")
        case .play(_): print("Interactor play")
        case let .enqueue(id): await enqueueLecture(withId: id)
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

    private func enqueueLecture(withId id: String) async {

        do {
            try await services.enqueueLecture(id: id)
            await fetchData()
        } catch {

            renderError(error)
        }
    }

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

            let lectures = try await services.lectures()
            render(.refresh(lectures))
        } catch {

            renderError(error)
        }
    }
}
