import UIKit

public struct HomeFeature {
    private let internalVC: HomeVC

    init(vc: HomeVC) {
        
        self.internalVC = vc
    }
    
    public func viewController() -> UIViewController { return internalVC}
}

extension HomeFeature: HomeFeatureViewInterface {
    
    public func view() -> UIView { internalVC.view }

    public func viewController() -> UIViewController? { internalVC }
}

extension HomeFeature: HomeFeatureLogicInterface {
    
}
