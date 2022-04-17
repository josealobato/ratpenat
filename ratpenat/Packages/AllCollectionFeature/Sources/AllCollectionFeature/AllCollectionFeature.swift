import UIKit

public struct AllCollectionFeature {
    private let internalVC: AllCollectionVC

    init(vc: AllCollectionVC) {
        
        self.internalVC = vc
    }
    
    public func viewController() -> UIViewController { return internalVC}
}

extension AllCollectionFeature: AllCollectionFeatureViewInterface {
    
    public func view() -> UIView { internalVC.view }

    public func viewController() -> UIViewController? { internalVC }
}

extension AllCollectionFeature: AllCollectionFeatureLogicInterface {
    
}
