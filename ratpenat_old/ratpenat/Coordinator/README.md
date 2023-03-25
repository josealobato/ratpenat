#  Coordinators

There is a hierarchy of coordinators, and a base coordinator provides basic functionality to the rest of the coordinators. Every coordinator contains a list of its child coordinators (`childCoordinators`) and has access to its parent coordinator.

# `AppCoordinator`

At the top, we have the primary coordinator called the `AppCoordinator`, who is in charge of setting up the application. In this case, this involves the creation of the `UITabBarController` by launching a coordinator for every tab.

