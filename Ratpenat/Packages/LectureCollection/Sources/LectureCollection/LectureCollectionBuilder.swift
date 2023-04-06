import UIKit
import SwiftUI

public struct LectureCollectionBuilder {

    public static func build(
        services: LectureCollectionServiceInterface
    ) -> UIViewController {

        let interactor = Interactor(services: services)

        return makeViewController(interactor: interactor)
    }
}

private extension LectureCollectionBuilder {

    static func makeViewController(interactor: Interactor) -> UIViewController {

        let presenter = Presenter(interactor: interactor)
        interactor.output = presenter

        let view = LectureCollectionView(presenter: presenter)

        return UIHostingController(rootView: view)
    }
}
