import Foundation
import struct Entities.Lecture

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: LectureDetailsServiceInterface
    let entityId: String
    var lecture: Lecture?

    init(entityId: String,
         services: LectureDetailsServiceInterface) {
        self.entityId = entityId
        self.services = services
    }

    // MARK: - Intercator input

    func request(_ event: InteractorEvents.Input) async {

        switch event {

        case .loadInitialData: await fetchData()
        case .save(let modifiedData): await onSave(changedLecture: modifiedData)
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
        // Work with coordinator and the SnackBar.
    }

    // MARK: - On actions

    private func onSave(changedLecture: ViewModel) async {

        lecture?.title = changedLecture.title

        do {

            if let lecture = lecture {

                try await services.save(lecture: lecture)
                // After saving we render the data again to update any
                // visual state.
                render(.refresh(lecture))
            }

        }  catch {

            renderError(error)
        }
    }
}

private extension Interactor {

    func fetchData() async {

        render(.startLoading)

        do {

            lecture = try await services.lecture(withId: entityId)
            if let lecture = lecture {

                render(.refresh(lecture))
            }
        } catch {

            renderError(error)
        }
    }
}
