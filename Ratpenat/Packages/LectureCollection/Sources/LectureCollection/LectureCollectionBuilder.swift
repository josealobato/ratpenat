import UIKit
import SwiftUI
import Coordinator

public struct LectureCollectionBuilder {

    public static func build(
        services: LectureCollectionServiceInterface,
        coordinator: CoordinationRequestProtocol
    ) -> UIViewController {

        let interactor = Interactor(services: services,
                                    coordinator: coordinator)

        return makeViewController(interactor: interactor)
    }
}

private extension LectureCollectionBuilder {

    static func makeViewController(interactor: Interactor) -> UIViewController {

        let presenter = Presenter(interactor: interactor)
        interactor.output = presenter

        let view = LectureCollectionView(presenter: presenter,
                                         interactor: interactor)

        return UIHostingController(rootView: view)
    }
}
