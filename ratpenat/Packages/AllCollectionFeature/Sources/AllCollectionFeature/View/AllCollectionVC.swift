import UIKit

final class AllCollectionVC: UIViewController {
    
    enum Section {
        case main
    }
    
    let basicCellId = "BasicCell"
    
    private let interactor: Interactor
    var dataSource: UICollectionViewDiffableDataSource<Section, ViewModel.Item>! = nil
    
    init(interactor: Interactor) {
        
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)

        // Configure the tab item
        // You need to set this very early otherwise it wont show on the
        // tab.
        self.tabBarItem.image = UIImage(systemName: "headphones")

        // The last one of those set is the one that is shown.
        //self.tabBarItem.title = "Draw it"
        self.title = "All"
    }

    required init?(coder: NSCoder) {
        
        fatalError("AllCollection VC is not desing to start from xib or storyboard")
    }

    override func loadView() {
        // We are providing the V of the VC, to have more control on the set up process.
        self.view = AllCollectionV()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
                
        interactor.performAction(input: .loadInitialData)
    }
}

extension AllCollectionVC {
    
    private func createLayout() -> UICollectionViewLayout {
        
        /// We create a new configuration for a list and
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        /// pass it to create the layout.
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension AllCollectionVC {
    
    private func configureHierarchy() {
        
        guard let view = self.view as? AllCollectionV else { return }
        // Most of the hierarchcy is set up on the AllCollectionV that we are setting up as base view of the VC.
        view.configureHierarchy(with: createLayout())
        view.collectionView.delegate = self
    }
    
    private func configureDataSource() {
        
        guard let view = self.view as? AllCollectionV else { return }
        
        // Registering the cell and providing the cell configuration for the items:
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ViewModel.Item> {
            // swiftlint:disable:next closure_parameter_position unused_closure_parameter
            (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
        }
        
        // Creating the data source:
        dataSource = UICollectionViewDiffableDataSource<Section, ViewModel.Item>(collectionView: view.collectionView) {
            // swiftlint:disable:next closure_parameter_position line_length
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: ViewModel.Item) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: identifier)
        }
        
        // And set the initial data:
        var snapshot = NSDiffableDataSourceSnapshot<Section, ViewModel.Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems([])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
