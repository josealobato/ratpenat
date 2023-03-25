import Foundation

public final class HomeFeatureFactory {

    public init() {}

    public func create() -> HomeFeature {

        let feature = HomeFeature(viewController: HomeVC())
        return feature
    }
}
