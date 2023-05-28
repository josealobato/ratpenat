# QueueManagementService (QMS)

Listing lectures

## Legend:
* [LCxxxx] requirement id.
* [ ] requirement implemented.
* [x] requirement implemented.
* [T] requirement with test coverage.
* [NT] requirement without test coverage (Unit Test). 


## Specification.

* [QMS0010] [x] [T] The service will load and build the sorted queue when started.

* [QMS0020] [x] [T] The User will be able to add lectures on top of the queue
* [QMS0030] [x] [T] The User will be able to add lectures at the bottom of the queue 
* [QMS0040] [x] [T] The User will be able to change the position of an item in the queue. 
* [QMS0050] [x] [T] The User will be able to get the queue list
* [QMS0060] [x] [T] The User will be able to get the next item to play (top of the queue) 
* [QMS0070] [x] [T] The User will be able to remove any element in the queue.


View
* [QMS0110] [x] [NT] 

Actions
* [QMS0210] [ ] [NT] 

## Settings
* [QMS0910] [ ] [NT] End offset to consider a lecture done when paused/skiped (defaul 5s) 

## Design:

(See the Monopic desing in the desing folder)

```
                                                                                                                                     
                                                              Offers and interface based                                             
                                                              on id Strings and Lecture                                              
                                                                      entities.                                                      
                                                                                                                                     
                                                                            .                                                        
                                                                           ( )                                                       
                                                                            '                                                        
                                                                            ▲                                                        
                                                                            │                                                        
                                                                            │                                                        
┌─────────────────────────────────────┐                  ┌─────────────────────────────────────┐                                     
│                                     │                  │                                     │                ┌───────────────────┐
│                                     │                  │                                     │                │                   │
│                                     │                  │                                     │                │                   │
│ CoordinatorServiceLifeCycleProtocol │                  │         QueueManagerService         │                │     Entities      │
│                                     │◀─────────────────│                                     │───────────────▶│                   │
│                                     │                  │                                     │                │                   │
│                                     │     It is a      │                                     │      Its       │                   │
│                                     │   coordinator    │                                     │   interface    └───────────────────┘
└─────────────────────────────────────┘     service      └─────────────────────────────────────┘    is based                         
                                                                            │                                                        
                                                                            │ Used to load the                                       
                                                                            │ initial queue and                                      
                                                                            │ persist all changes on                                 
                                                                            │                                                        
                                                                            ▼                                                        
                                                         ┌─────────────────────────────────────┐                                     
                                                         │                                     │                                     
                                                         │                                     │                                     
                                                         │                                     │                                     
                                                         │     LecturesRepositoryInterface     │                                     
                                                         │                                     │                                     
                                                         │                                     │                                     
                                                         │                                     │                                     
                                                         │                                     │                                     
                                                         └─────────────────────────────────────┘                                     
```
