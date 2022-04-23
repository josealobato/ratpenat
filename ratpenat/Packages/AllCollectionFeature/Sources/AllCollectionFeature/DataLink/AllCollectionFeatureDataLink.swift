import Foundation
import Entities

/// A data like allows the Feature to collect the data it needs
public protocol AllCollectionFeatureDataLink {
    
    func allAudioAssets() -> [AudioAsset]
}
