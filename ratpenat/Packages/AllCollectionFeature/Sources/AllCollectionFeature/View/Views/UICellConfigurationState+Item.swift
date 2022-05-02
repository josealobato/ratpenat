import UIKit

/// Declare a custom key for a custom `item` property.
extension UIConfigurationStateCustomKey {
    static let item = UIConfigurationStateCustomKey("com.ratpenat.ItemListCell.item")
}

/// Declare an extension on the cell state struct to provide a typed property for this custom state.
extension UICellConfigurationState {
    
    var item: ViewModel.Item? {
        
        get { return self[.item] as? ViewModel.Item }
        set { self[.item] = newValue }
    }
}
