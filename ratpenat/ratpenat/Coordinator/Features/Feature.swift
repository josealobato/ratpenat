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
            let vc = AllCollectionFeatureFactory().create().viewController()
            return vc
            
        default:
            return nil
        }
    }
}
