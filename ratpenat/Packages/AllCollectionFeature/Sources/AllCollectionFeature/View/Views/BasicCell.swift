import UIKit

private enum Constant {
    static let basicOffset: CGFloat = 16
    static let titleToBottom: CGFloat = 60
    static let interTextSpace: CGFloat = 4
}

/// Layout of the basic cell:
/// ┌────────────────────────────┐
/// │   Title                    │
/// │   subject - duration       │
/// └────────────────────────────┘
/// (see the design on the doc/assets)
class BasicCell: UICollectionViewListCell {
    
    var title: UILabel!
    var subTitle: UILabel!
    
    required init?(coder: NSCoder) {
        fatalError("IB is not supported!")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemBackground
        setUpTitle()
//        setUpSubtitle()
    }
    
    private func setUpTitle() {
        
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.basicOffset),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.titleToBottom),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.basicOffset),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.basicOffset)
        ])
        title = textLabel
    }
    
    private func setUpSubtitle() {
        
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Constant.interTextSpace),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.titleToBottom),
            textLabel.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.basicOffset)
        ])
        subTitle = textLabel
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
        subTitle.text = nil
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        return layoutAttributes
//    }
}
