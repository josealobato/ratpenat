import UIKit

// The delegate has to be an NSObject.
class MainTabBarDelegate: NSObject {}

extension MainTabBarDelegate: UITabBarControllerDelegate {

    func tabBarControllerSupportedInterfaceOrientations(_ tabBarController: UITabBarController)
    -> UIInterfaceOrientationMask {

        print("call to tabBarControllerSupportedInterfaceOrientations")

        return .all
    }

    // I guess this is only called when we "present" a tabview controller.
    // It is not being called when we use it as a root view Controller.
    func tabBarControllerPreferredInterfaceOrientationForPresentation(_ tabBarController: UITabBarController)
    -> UIInterfaceOrientation {

        print("call to tabBarControllerPreferredInterfaceOrientationForPresentation")

        return .portrait
    }

    // Type `tab` for xcode to offer all the delegate stuff

}
