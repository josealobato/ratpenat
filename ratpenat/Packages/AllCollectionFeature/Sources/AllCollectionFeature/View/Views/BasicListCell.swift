import UIKit

/// Layout of the basic cell:
/// ┌────────────────────────────┐
/// │   Title         Duration > │
/// │   description              │
/// └────────────────────────────┘
/// (see the design on the doc/assets)
final class BasicListCell: ItemListCell {
    
    // Here we define the default configuration because it is requested on serveral places (setup and update)
    private func defaultListContentConfiguration() -> UIListContentConfiguration { return .subtitleCell() }
    
    // We create the content view of the cell.
    private lazy var listContentView = UIListContentView(configuration: defaultContentConfiguration())
    
    // Plus, we add one extra view for the duration
    private let durationLabel = UILabel()
    
    // We keep some constrains to be updated on update request.
    private var customViewConstraints: (durationLabelLeading: NSLayoutConstraint,
                                         durationLabelTrailing: NSLayoutConstraint)?
    
    private func setupViewsIfNeeded() {
        // We only run this methods if the the views are you yet setup
        guard customViewConstraints == nil else { return }
        
        // Set the list content view on the left.
        contentView.addSubview(listContentView)
        listContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            listContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        // Allow the list content view to compress horizontally:
        let defaultHorizontalCompressionResistance = listContentView.contentCompressionResistancePriority(for: .horizontal)
        listContentView.setContentCompressionResistancePriority(defaultHorizontalCompressionResistance - 1, for: .horizontal)
        
        // Set the duration label on the right side.
        contentView.addSubview(durationLabel)
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = (
            durationLabelLeading: durationLabel.leadingAnchor.constraint(greaterThanOrEqualTo: listContentView.trailingAnchor),
            durationLabelTrailing: contentView.trailingAnchor.constraint(equalTo: durationLabel.trailingAnchor)
        )
        NSLayoutConstraint.activate([
            durationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            constraints.durationLabelLeading,
            constraints.durationLabelTrailing
        ])
        
        // Save the custom constraint to update later.
        customViewConstraints = constraints
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        
        setupViewsIfNeeded()
        
        // There are two things to configure here, the content view and the custom part.
        
        // First we configure the standard cell.
        var contentConfiguration = defaultContentConfiguration().updated(for: state)
        contentConfiguration.imageProperties.preferredSymbolConfiguration = .init(font: contentConfiguration.textProperties.font,
                                                                                  scale: .large)
        contentConfiguration.text = state.item?.title
        contentConfiguration.secondaryText = "secondary text"
        contentConfiguration.axesPreservingSuperviewLayoutMargins = []
        listContentView.configuration = contentConfiguration
        
        // For the custom part we want it to resemple to a standard value cell, so we will get its default
        // configuration to get reference values.
        let valueConfiguration = UIListContentConfiguration.valueCell().updated(for: state)
        
        // And configure the text accordingly.
        durationLabel.text = state.item?.duration
        durationLabel.textColor = valueConfiguration.secondaryTextProperties.resolvedColor()
        durationLabel.font = valueConfiguration.secondaryTextProperties.font
        durationLabel.adjustsFontForContentSizeCategory = valueConfiguration.secondaryTextProperties.adjustsFontForContentSizeCategory
        
        // adjust the custom constraints with the current properties and state.
        // Notice that we have set the constants unset when se setup the view, but now we adjust them
        customViewConstraints?.durationLabelLeading.constant = contentConfiguration.directionalLayoutMargins.trailing
        customViewConstraints?.durationLabelTrailing.constant = contentConfiguration.directionalLayoutMargins.leading
    }
}
