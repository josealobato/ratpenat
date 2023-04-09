import UIKit
import SwiftUI

public struct PlayerBuilder {

    public static func build(
        services: PlayerServiceInterface
    ) -> UIViewController {

        let interactor = Interactor(services: services)

        return makeViewController(interactor: interactor)
    }
}

private extension PlayerBuilder {

    static func makeViewController(interactor: Interactor) -> UIViewController {

        let presenter = Presenter(interactor: interactor)
        interactor.output = presenter

        let view = PlayerView(presenter: presenter)

        return UIHostingController(rootView: view)
    }
}
