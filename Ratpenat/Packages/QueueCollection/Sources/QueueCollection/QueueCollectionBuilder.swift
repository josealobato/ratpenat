import UIKit
import SwiftUI

public struct QueueCollectionBuilder {

    public static func build(
        services: QueueCollectionServiceInterface
    ) -> UIViewController {

        let interactor = Interactor(services: services)

        return makeViewController(interactor: interactor)
    }
}

private extension QueueCollectionBuilder {

    static func makeViewController(interactor: Interactor) -> UIViewController {

        let presenter = Presenter(interactor: interactor)
        interactor.output = presenter

        let view = QueueCollectionView(presenter: presenter,
                                         interactor: interactor)

        return UIHostingController(rootView: view)
    }
}
