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

IMPORTANT: A lecture is playing when it has a playing possition but it can be paused or playing in the player.
We can also say that it not playing when the play possition is nil.

* When the user informs that a lesson started playing providing a time stamp.
    * [QMS0080] [x] [T] It will do nothing if the lesson is not in the queue.
        Dev. Note: We do not want to throw an exception becase the upper levels can do nothing
        with that information. Anyway that shouldnt happen and we will log a warning message for debug.
    * [QMS0081] [x] [T] It will move the lesson at the top of the queue if not already there.
    * [QMS0082] [x] [T] It will set and persist the new play possition for that lecture.
    * [QMS0083] [ ] [ ] It will broadcast that the given lesson is playing. 
    
* When the user informs that a lesson paused playing providing a time stamp.
    Dev. Note: Pausing will mostly update the playing position for that lecture.
    * [QMS0090] [x] [T] It will do nothing if the lesson is not in the queue.
        Dev. Note: We do not want to throw an exception becase the upper levels can do nothing
        with that information. Anyway that shouldnt happen and we will log a warning message for debug.
    * [QMS0091] [x] [T] It will set and persist the new play possition for that lecture.
    * [QMS0093] [ ] [ ] It will broadcast that the given lesson is paused. 
    
* When the user informs that a lesson is skiped.
    Dev. Note: Skipped do no set it to done.
    * [QMS0100] [x] [T] It will do nothing if the lesson is not in the queue.
    * [QMS0110] [x] [T] It move it to the end of the queue
    * [QMS0120] [ ] [ ] It will cleand and persist the play possition.
    
* When the user request to play a lesson,

View
* [QMS0110] [x] [NT] 

Actions
* [QMS0210] [ ] [NT] 

## Settings
* [QMS0910] [ ] [NT] End offset to consider a lecture done when paused/skiped (defaul 5s)
* [QMS0920] [ ] [NT] Skipping a lecture will: send to the end of the queue (default) / send to play next (second possition) 

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
