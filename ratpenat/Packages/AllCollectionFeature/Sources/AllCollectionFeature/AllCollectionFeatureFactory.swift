import Foundation

public final class AllCollectionFeatureFactory {
    
    public init() {}

    public func create() -> AllCollectionFeature {
        let feature = AllCollectionFeature(viewController: AllCollectionVC())
        return feature
    }
}
