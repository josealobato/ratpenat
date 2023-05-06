# RData or Ratpenat Data (DT) 

A description of this package.

## Legend:
* [DTxxxx] requirement id.
* [ ] requirement implemented.
* [x] requirement implemented.
* [T] requirement with test coverage.
* [NT] requirement without test coverage. 

## General design

* [DT0010] [x] [NT] Every repository has a public interface and builder. The rest of the implementation is private.
* [DT0020] [x] [NT] The Data interface is composed by: Data entitiles, repository protocol and repository builder. The rest is private.

```
┌────────────────────────────────────┐                                          
│RData                               │                                          
│(Basics for a generic repository)   │                                          
└────────────────────────────────────┘                                          
                                                                                
┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─                                                         
       Interface       │                                   ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐
│                                                                 Storage       
                       │                                   │                   │
│                                                                               
     ┌─────────────┐   │                                   │                   │
│    │   Builder   │───────────────────────┐                                    
     └─────────────┘   │                   │               │                   │
│                                          │                                    
    ┌─────────────┐    │                   │               │                   │
│   │ DataEntity  │◀─────┐                 │                                    
    └─────────────┘    │ │                 ▼               │                   │
│          ▲             │       ┌───────────────────┐                          
           │           │ │       │                   │     │                   │
│          │             │       │                   │                          
    ┌─────────────┐    │ │       │    Repository     │     │  ┌─────────────┐  │
│   │  Interface  │◀─────┴───────│                   │───────▶│ StorageData │   
    └─────────────┘    │         │                   │     │  └─────────────┘  │
│                                │                   │                          
                       │         └───────────────────┘     │  ┌─────────────┐  │
│                                                             │    JSON     │   
                       │                                   │  └─────────────┘  │
└ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─                                     ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ 
```
(See the monopic design on the Design folder)

### Storage 

Holds the data and it is in charge of decoding and coding.

### Interface

The `Builder` is public and return an object of type `Interface` that handles `DataIdentities`.

### Repository

The `Repository` implements the interface and do the work by accesing the `StorageData`

