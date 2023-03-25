import UIKit
import AllCollectionFeature

enum Feature: String {

    case home
    case allCollection
}

extension Feature {

    func vc() -> UIViewController? {
        switch self {
        case .allCollection:
            let viewController = AllCollectionFeatureFactory().create().viewController()
            return viewController

        default:
            return nil
        }
    }
}
