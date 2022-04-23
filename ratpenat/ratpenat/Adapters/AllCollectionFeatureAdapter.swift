import Foundation
import AllCollectionFeature
import Entities

class AllCollectionFeatureAdapter {
    
}

extension AllCollectionFeatureAdapter: AllCollectionFeatureDataLink {
    
    func allAudioAssets() -> [AudioAsset] {
        
        var result: [AudioAsset] = []
        for i in 1...100 {
            
            result.append(AudioAsset(id: i, title: "Asset num \(i)"))
        }
        return result
    }
    
}
