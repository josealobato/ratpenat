import UIKit

/// This list cell subclass is an abstract class with a property that holds the item the cell is displaying,
/// which is added to the cell's configuration state for subclasses to use when updating their configuration.
class ItemListCell: UICollectionViewListCell {
    private var item: ViewModel.Item?
    
    func updateWithItem(_ newItem: ViewModel.Item) {
        
        guard item != newItem else { return }
        item = newItem
        setNeedsUpdateConfiguration()
    }
    
    override var configurationState: UICellConfigurationState {
        
        var state = super.configurationState
        state.item = self.item
        return state
    }
}
