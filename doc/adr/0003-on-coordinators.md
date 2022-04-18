# Coordinators

* Status: accepted
* Deciders: Jose A. Lobato
* Date: 2022-04-17 

Technical Story: https://github.com/josealobato/ratpenat/issues/1

## Context and Problem Statement

We want every Feauture to be as independent of the others as possible. 
We also need th flow of the application to be contron in a small set of objects.

## Considered Options

* Routers. Creating a router for every Feature
* Coordinators. Creating a coordinator for every flow of the application.

## Decision Outcome

**Chosen option**: Coordinatos, because for this type of the application it provides a nice separation of concerns at the same time tha display correctlly the flow of the application.

There is a hierarchy of coordinators, and a base coordinator provides basic functionality to the rest of the coordinators. Every coordinator contains a list of its child coordinators (`childCoordinators`) and has access to its parent coordinator.

At the top, we have the primary coordinator called the `AppCoordinator`, who is in charge of setting up the application. In this case, this involves the creation of the `UITabBarController` by launching a coordinator for every tab.