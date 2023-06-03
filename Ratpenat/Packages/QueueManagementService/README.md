# QueueManagementService (QMS)

The Queue Management Service (QMS) holds the queue of lectures to play. Its main jobs are:

* Load the queue from Storage
* Accept and manage requests to add, remove and sort the queue.
* Offer the full queue as well as the next lecture to play.
* Accept and manage requests to change the queue's state like  start playing, pause, skip and done playing.
* Broadcast events on the queue for other modules to react.

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
    * [QMS0082] [ ] [ ] It will clean the play possition of any other lecture in the queue.
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
    * [QMS0101] [x] [T] It move it to the end of the queue
    * [QMS0102] [x] [T] It will cleand and persist the play possition.
    * [QMS0103] [ ] [ ] If skiping happen when only x seconds (config) are left, it is considered done.
    
* When the user informs that a lesson is Done.
    * [QMS0110] [x] [T] It will do nothing if the lesson is not in the queue.
    * [QMS0111] [x] [T] It will marked as done (set time stamp)
    * [QMS0112] [x] [T] It will remove it from the queue (not playing and not queue position).

* When the user request to play a lesson that might or not be in the queue.
    * [QMS0120] [x] [T] If it is not in the queue it will be fetch added to the queue.
    * [QMS0121] [x] [T] Once in the lecture is in the queue it will be set at the top of the queue.
    * [QMS0122] [ ] [ ] It will broadcast a request to play the next lecture (the one at the top).

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
