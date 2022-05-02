import Foundation
import AllCollectionFeature
import Entities

class AllCollectionFeatureAdapter {
    
}

extension AllCollectionFeatureAdapter: AllCollectionFeatureDataLink {
    
    func allAudioAssets() -> [AudioAsset] {
        
        let subjects = [
            Subject(id: 1, name: "Maths", color: "#aabbcc"),
            Subject(id: 2, name: "Physics", color: "#ffbbcc"),
            Subject(id: 2, name: "Engineering", color: "#ff33cc")
        ]
        
        var result: [AudioAsset] = []
        for i in 1...100 {
            
            let subject = subjects[i % 3]
            result.append(AudioAsset(id: i,
                                     title: "Asset num \(i)",
                                    subject: subject))
        }
        return result
    }
    
}
