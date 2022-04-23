import Foundation

public final class AllCollectionFeatureFactory {
    
    public init() {}

    public func create(dataLink: AllCollectionFeatureDataLink) -> AllCollectionFeature {
        
        let presenter = Presenter()
        let interactor = Interactor(dataLink: dataLink,
                                    output: presenter)
        let vc = AllCollectionVC(interactor: interactor)
        presenter.view = vc
        let feature = AllCollectionFeature(viewController: vc)
        
        return feature
    }
}
