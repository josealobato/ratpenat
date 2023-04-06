import UIKit

class HomeVC: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)

        // Configure the tab item
        // You need to set this very early otherwise it wont show on the
        // tab.
        self.tabBarItem.image = UIImage(systemName: "play")

        // The last one of those set is the one that is shown.
        //self.tabBarItem.title = "Draw it"
        self.title = "Play"
    }

    required init?(coder: NSCoder) {
        fatalError("Home VC not desing to start from xib or storyboard")
    }

    public override func loadView() {
        self.view = HomeV()
    }
}
