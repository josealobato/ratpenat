import UIKit

class AllCollectionVC: UIViewController {
    
    init() {
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
        fatalError("AllCollection VC not desing to start from xib or storyboard")
    }
    
    override func loadView() {
        self.view = AllCollectionV()
    }
}
