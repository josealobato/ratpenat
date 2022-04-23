import Foundation

public final class AllCollectionFeatureFactory {
    
    public init() {}

    public func create() -> AllCollectionFeature {
        
        let interactor = Interactor()
        let vc = AllCollectionVC(interactor: interactor)
        let feature = AllCollectionFeature(viewController: vc)
        
        return feature
    }
}
