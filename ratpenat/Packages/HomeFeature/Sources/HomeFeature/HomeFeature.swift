import UIKit
import FoundationToolkit

public struct HomeFeature {
    private let internalVC: HomeVC

    init(vc: HomeVC) {
        
        self.internalVC = vc
    }
}

// MARK: - Interface implementation

extension HomeFeature: HomeFeatureViewInterface {
    
    public func view() -> UIView { internalVC.view }

    public func viewController() -> UIViewController? { internalVC }
}

extension HomeFeature: HomeFeatureLogicInterface {
    
}

// MARK: - Action implementation

extension HomeFeature: ActionRequester {
    public var actionRequest: ActionRequest {
        get {
//            self.internalVC.showRequest ?? { _ in }
            { _ in }
        }
        set(newValue) {
//            self.internalVC.showRequest = newValue
        }
    }
}

