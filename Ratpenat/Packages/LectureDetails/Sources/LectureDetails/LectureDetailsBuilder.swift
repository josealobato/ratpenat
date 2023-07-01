import UIKit
import SwiftUI

public struct LectureDetailsBuilder {

    public static func build(
        entityId: String,
        services: LectureDetailsServiceInterface
    ) -> UIViewController {

        let interactor = Interactor(entityId: entityId,
                                    services: services)

        return makeViewController(interactor: interactor)
    }
}

private extension LectureDetailsBuilder {

    static func makeViewController(interactor: Interactor) -> UIViewController {

        let presenter = Presenter(interactor: interactor)
        interactor.output = presenter

        let view = PackageView(presenter: presenter,
                               interactor: interactor)

        return UIHostingController(rootView: view)
    }
}
