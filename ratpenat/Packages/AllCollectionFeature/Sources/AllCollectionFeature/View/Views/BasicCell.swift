import UIKit

class BasicCell: UICollectionViewCell {
    
    var title: UILabel!
    
    required init?(coder: NSCoder) {
        fatalError("IB is not supported!")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        title = textLabel
        
        contentView.backgroundColor = .systemBackground
//        self.textLabel.textAlignment = .center
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
    }
}
