# Coordinator (COO)

This package contains the coordinator interfaces and some other reusable parts.

## Legend

COO: Coordinator

## Specification

There is no formal specification for the Coordinator.

### History log

(Note that the time is essential to make sure that the link is attached to a version on Spaces)
2022-12-05 Jose A Lobato - Initial version of this document.

## Introduction

## Architectural Design

By definition, the Coordinator gets requests from different modules and "knows" what to do with them depending on the module requesting and the type of request. This makes modules independent of each other, and no module knows about any other module's behaviour or interface. That is great, but it comes with a price. The Coordinator is the one that receives the requests, so he is also the one that knows it all. This will soon become a problem since the Coordinator will grow huge. Also, we can notice one SRP violation since the Coordinator is doing at least two things: coordinating the modules' presentation and instantiating the new module.

To fix this issue, we make the Coordinator agnostic of creating a new module by delegating this responsibility to a manager. There will be one manager for every type of request, and the Coordinator will be given a dictionary that maps every request to the type of manager that should handle it. When the Coordinator receives a request, it will check the type of Manager that handles that request. Once it has that manager, it will ask him to do its job and provide the new module to coordinate. Notice that with this approach, the Coordinator doesn't even know which manager handles every request, since it is given with the mapping dictionary.

With this approach, the module provides two protocols for the Coordinator mechanics. `FlowCoordinator` for the Coordinator and `RequestCoordinatorManager` for the Manager. It also provides a specialization of the `FlowCoordinator` called `BaseFlowCoordinator` with many of the Coordinator features already implemented. Use the `BaseFlowCoordinator` instead of creating a new coordinator from scratch to get most of the basic functionality (More on this later).

```
┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐                      
│Coordinator Package                                                                                              │                      
│                                                                                                ┌─────────────┐  │                      
│                                                                                                │  <<enum>>   │  │                      
│                                                                                                │ Coordinated │  │                      
│                                                                                                └─────────────┘  │                      
│                                                                                                                 │                      
│                                                                                         ┌────────────────────┐  │                      
│                                                                                         │      <<enum>>      │  │                      
│                                                                                         │CoordinationRequest │  │                      
│                                                                                         └────────────────────┘  │                      
│      ┌───────────────────┐                                                                                      │                      
│      │   <<protocol>>    │                                                        ┌──────────────────────────┐  │                      
│      │  FlowCoordinator  │                                                        │         <<enum>>         │  │                      
│      │                   │                                                        │ CoordinationRequestName  │  │                      
│      └───────────────────┘                                                        │                          │  │                      
│                ▲                                                                  └──────────────────────────┘  │                      
│                │                                                                                                │                      
│                │                                                                  ┌───────────────────────────┐ │                      
│                │ <<conforms>>                                                     │       <<protocol>>        │ │                      
│                │                                                                  │CoordinationRequestProtocol│◀┼────┐                 
│                │                                                                  └───────────────────────────┘ │    │                 
│   ┌────────────────────────┐   ┌──────────────────────────┐                                                     │    │                 
│   │       <<class>>        │   │        <<class>>         │ ┌────────────────────────────────────────┐          │    │                 
│   │  BaseFlowCoordinator   │   │RequestCoordinatorManager │ │             <<typealias>>              │          │    │                 
│   │                        │   │                          │ │  RequestCoordinatorMappingDictionary   │          │    │                 
│   └────────────────────────┘   └──────────────────────────┘ └────────────────────────────────────────┘          │    │                 
│                △                             △                                   ▲                              │    │                 
│                │                             │                                   │                              │    │                 
└────────────────┼─────────────────────────────┼───────────────────────────────────┼──────────────────────────────┘    │                 
                 │                             │                                   │                                   │                 
                 │                             │                                   │                                   │                 
                 │                             └────────────────────────┐          │                                   │                 
                 └────────────────────────┬─────────────────────────────┼──────────┘                                   │                 
              ┌───────────────────────────┼─────────────────────────────┼─────────────────────────┐                    │                 
              │Application                │                             │                         │                    │                 
              │                           │                             │                         │                    │                 
              │                           │                             │                         │  ┌──────────────────────────────────┐
              │                           │                   ┌──────────────────┐                │  │                                  │
              │                           │                 ┌─┤                  │                │  │                                  │
              │                           │                 │ │     Manager      │                │  │                                  │
              │                 ┌──────────────────┐        │ │                  │                │  │Any Module requesting coordination│
              │               ┌─┤                  │        │ └────────────────┬─┘                │  │                                  │
              │               │ │   Coordinator    │        └──────────────────┘                  │  │                                  │
              │               │ │                  │                                              │  │                                  │
              │               │ └────────────────┬─┘                                              │  │                                  │
              │               └──────────────────┘                                                │  └──────────────────────────────────┘
              │                                                                                   │                                      
              │                                                                                   │                                      
              │                                                                                   │                                      
              │                                                                                   │                                      
              └───────────────────────────────────────────────────────────────────────────────────┘                                      
```

## The `BaseFlowCoordinator`

It is a specialization from the `FlowCoordinator`. It should be used as the base coordinator on the application.

It implements the following features:

1. It is attending requests with the given Managers. Given a mapping dictionary of managers, it will instantiate the right manager for every request, and delegate the request to that manager. It will also hold and dispose of the managers as they finish their work.

# How to use the Coordinator package

In the following sections, instructions are given on the different procedures to use the Coordinator from the application or an individual module.

## How to use the Coordinator in the application

Some prerequisites:

1. A manager for every request should be implemented. It is advised to create one manager for every request, but it is not mandatory.
2. A dictionary should exist mapping every possible request to a manager that will handle that request. A request without a manager will cause no harm.

With the basics in place, you could:

1. Instantiate or extend the `BaseFlowCoordinator`.
2. On instantiation, give the Coordinator the manager mapping dictionary.
3. Provides the root view controller and the navigation controller.

Just with that, the Coordinator will do its magic.

## How to use the Coordinator with a new module

To use the Coordinator with your new module, follow these steps:

1. On the `Coordinated` enumeration, add your new module's name.
2. Verify that the coordination request needed by your module is present in the `CoordinationRequestName` enumeration. Otherwise, a new coordinator request will be needed (more later).
3. Prepare your module to receive a `CoordinationRequestProtocol` instance (injection). The protocol defines the method you can use inside your module to request coordination.
4. Request coordination by calling the method in `CoordinationRequestProtocol`, identifying yourself (`Coordinated`), and requesting one of the existing coordination requests (`CoordinationRequestName`).

## How to add a new coordination request

The coordinator infrastructure comes with many already defined requests (see `CoordinationRequestName`), but surely you will need to add new ones. Follow these steps:

1. Add a new request name in `CoordinationRequestName`
2. Add a new request signature in `CoordinationRequest`
3. On your application, add a new manager to handle the request (see the already existing managers for inspiration)
4. Add the new pair (`requestName:ManagerType`) to the mapping dictionary for that Coordinator.

And that is all.

## Services

A service is an object managed by the Coordinator that starts and stops at the same time that the Coordinator. Think of it as a daemon whose lifecycle is controlled by the Coordinator. Implement a service whenever you need some functionality that runs while the Coordinator is alive.

```
┌────────────────────────────────────────────────────────────┐
│                    Coordinator Package                     │
│                                                            │
│     ┌──────────────────────────┐                           │
│     │       <<protocol>>       │                           │
│     │CoordinatorServiceProtocol│                           │
│     │                          │                           │
│     └──────────────────────────┘                           │
│                   ▲  <<conforms>>                          │
│                   │                                        │
│   ┌──────────────────────────────┐                         │
│   │         <<protocol>>         │                         │
│   │CoordinatorServiceLifeCyclePro│                         │
│   │            tocol             │                         │
│   └──────────────────────────────┘                         │
│                                                            │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

The Coordinator receives the list of services to handle on creation.

Services will:

* receive Start and Stop events at the same time as the Coordinator.
* receive life cycle events (`willEnterBackground`, `didEnterBackground`, etc.) if it is a `CoordinatorServiceLifeCycleProtocol`.
* have access to the Coordinator to allow it to request coordination.

## Context

The Coordinator Context is a data structure that contains data considered constant by the Manager. The managers inject this constant struct into the presented package, which is treated like constant data (hence the `context` name). But in the context of the application, the data might not be constant, so the Coordinator provides a mechanism to keep this data up to date. In the following paragrams, this mechanism will be described.

```
┌────────────────────────────────────────────────────────────────────────────────┐
│                              Coordinator Package                               │
│                                                                                │
│     ┌──────────────────────────┐                                               │
│     │       <<protocol>>       │          <<uses>>                             │
│     │    CoordinatorContext    │◀─────────────────────────┐                    │
│     │                          │                          │                    │
│     └──────────────────────────┘                          │                    │
│                   ▲    <<uses>>                           │                    │
│                   │                                       │                    │
│   ┌──────────────────────────────┐        ┌──────────────────────────────┐     │
│   │         <<protocol>>         │        │         <<protocol>>         │     │
│   │   ContextProviderProtocol    │        │       FlowCoordinator        │     │
│   │                              │        │                              │     │
│   └──────────────────────────────┘        └──────────────────────────────┘     │
│                                                                                │
│                                                                                │
└────────────────────────────────────────────────────────────────────────────────┘
```

The coordinator expects that one of the services will be in charge of updating the context. To fulfill that role, a service should implement the `ContextProviderProtocol`. When the coordinator loads the services, it will look for this service, and when found, it will be appointed as the source of the Context. That service is in charge of properly updating the context using the life cycle calls available to all services.

When a manager is instantiated, it will have access to the coordinator that created it via the `FlowCoordinator` protocol. There, the manager will have access to the most recent context and be able to use it on the module it is in charge of.

Internally, when a coordinator does not have a service that provides a context, it will try to get it from its parent.

### How to create and use a context on the app

The process is simple:

1. Create a context to hold your data conforming to `CoordinatorContext`.
2. Create a service that also conforms to `CoordinatorServiceLifeCycleProtocol`. Use this one to receive life cycle events to update the service at key moments.
3. Make that service conforms to `ContextProviderProtocol`.
4. Pass that service like any other when creating the coordinator.

Finally, on your managers, ensure to get the context and pass it to the modules they are creating.

### Acceptance Criteria

There is no formal specification for the Coordinator.

## Graphical Desing

Find the desing file [here](Desing/CoordinatorDesing.monopic)
