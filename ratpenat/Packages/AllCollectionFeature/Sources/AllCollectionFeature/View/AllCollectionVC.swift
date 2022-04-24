import UIKit

final class AllCollectionVC: UIViewController {
    
    let basicCellId = "BasicCell"
    
    private let interactor: Interactor
    var viewModel = ViewModel(items: [])
    
    weak var collectionView: UICollectionView!
    
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

        self.view = AllCollectionV()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view = self.view as? AllCollectionV else { return }
        
        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        
        view.collectionView.register(BasicCell.self, forCellWithReuseIdentifier: basicCellId)
        
        interactor.performAction(input: .loadInitialData)
    }
}
