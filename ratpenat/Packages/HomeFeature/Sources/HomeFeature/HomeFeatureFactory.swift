import Foundation

public final class HomeFeatureFactory {
    
    public init() {}
    
    public func create() -> HomeFeature {
        
        let feature = HomeFeature(vc: HomeVC())
        
        return feature
    }
}
