# MediaFileSystem (MFS)

The MediaFileSystem is in charge of abstracting the file system. That way the rest of the system doesn't need to know
where and how the media files are stored. 

The MediaFileSystem shares three concepts with the rest of the system (NOTE: "consumer system" is the system using MFS.):

* **Managed Files**: Files that have been managed before. In the sense that they are not new to the consumer system, so that
the system has those files under control on its records.
 
* **Unmanaged Files**: Files that are new to the system and might not be available on the consumer systems records.

* **Archived Files**: Managed Files that are saved to a separed location to keep the system clean.

The consumer system can: 

* Access to the manange, unmanaged and archived files.
* Modify the main file data (id, name)
* Mark files as managed.
* Mark files as archived/unarchived.
* Delete files.

## Single Responsibility

Abstract the file system details to the rest of the application.

## Legend:

* [MMSxxxx] requirement id.
* [ ] requirement implemented.
* [x] requirement implemented.
* [T] requirement with test coverage.
* [NT] requirement without test coverage (Unit Test). 

## Specification.

* [MFS0010] [x] [NT] On initialization it will create the Manage and Inbox folders.
* [MFS0020] [x] [NT] On initialization it will create the archive folders.
* [MFS0030] [x] [NT] On initialization, if the managed folder has just been created, the package media resources will be copied there.
* [MFS0040] [x] [NT] The user should be able to mark files as managed. When done it will received un updated file.
* [MFS0050] [x] [NT] The user should be able to mark files as archived. When done it will received un updated file.
* [MFS0060] [x] [NT] The user should be able to mark files as unarchived (back to managed). When done it will received un updated file.
* [MFS0070] [x] [NT] The user should be able to delete a file.

## Settings

None.

## Design

(See the Monopic desing in the desing folder)

```
                     ┌──────────────────────────────────────┐                                     
                     │<<actor>>                             │                                     
                     │MediaFileSystem                       │                                     
                     │---------------------------------     │                                     
                     │managedFiles() -> [MediaFile]         │            MFS - Abstracts the file 
                     │unmanagedFiles() -> [MediaFile]       │            system and knows how     
                     │                                      │─ ─ ─ ─ ─ ─ files are managed on the 
                     │manageFile(MediaFile) -> MediaFile?   │            file system              
                     │archiveFile(MediaFile) -> MediaFile?  │                                     
                     │unarchiveFile(MediaFile) -> MediaFile?│                                     
                     │deleteFile(MediaFile)                 │                                     
                     └──────────────────────────────────────┘                                     
                                         │                                                        
                                         │                                                        
                                         │                                                        
                                         ▼                                                        
┌─────────────────────────────────────────────────────────────────────────────────┐               
│FileSystem                                                                       │               
│                                                                                 │               
│         ┌─────────────────┐    ┌─────────────────┐   ┌─────────────────┐        │               
│         │      inbox      │    │    unmanage     │   │     archive     │        │               
│         │    (folder)     │    │    (folder)     │   │    (folder)     │        │               
│         │                 │    │                 │   │                 │        │               
│         └─────────────────┘    └─────────────────┘   └─────────────────┘        │               
│                                                                                 │               
│                                                                                 │               
└─────────────────────────────────────────────────────────────────────────────────┘                           
```

## Testing

Since we are dealing here with the file system we are not using unit test, instead you can test 
with the following code:

```
            // get the files
            let manageFiles = await fileSystem.managedFiles()

            // Pause here and manually copy files to the inbox
            let newFiles = fileSystem.unmanagedFiles()
            print(" ------------- ")
            print(" New: \(newFiles[0])")

            var newFile = newFiles[0]
            newFile.id = "666"
            newFile.name = "The Number Of The Beast"
            let managedFile = fileSystem.manageFile(file: newFile)
            print(" ------------- ")
            print(" Managed: \(managedFile)")

            let archived = fileSystem.archiveFile(file: managedFile!)
            print(" ------------- ")
            print(" Archved: \(archived)")

            var unarchived = fileSystem.unarchiveFile(file: archived!)!
            print(" ------------- ")
            print(" Unarchived: \(unarchived)")

            // modify one
            unarchived.id = "222"
            unarchived.name = "My best version"
            let modified = fileSystem.updateFile(file: unarchived)
            print(" ------------- ")
            print(" Unarchived: \(modified)")
```
