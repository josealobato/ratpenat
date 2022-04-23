import UIKit
import AllCollectionFeature

// Warning: This Feature Factory is undes investigation.

enum Feature: String {

    case home
    case allCollection
}

extension Feature {

    func vc() -> UIViewController? {
        switch self {
        case .allCollection:
//            let viewController = AllCollectionFeatureFactory().create().viewController()
//            return viewController
            return nil

        default:
            return nil
        }
    }
}
