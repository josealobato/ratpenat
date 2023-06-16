import Foundation
import Player
import Entities
import Foundation

extension Lecture: PlayerLecture { }

class PlayerAdapter: PlayerServiceInterface {

    let useShorts = true

    // This is not yet connected to the Data so we provide demo data here.
    var shortTestLectures = [
        Lecture(id: "1",
                title: "Test 1",
                category: nil,
                mediaURL: Bundle.main.url(forResource: "Test-1", withExtension: "mp3")!,
                imageURL: nil),
        Lecture(id: "1",
                title: "Test 2",
                category: nil,
                mediaURL: Bundle.main.url(forResource: "Test-2", withExtension: "mp3")!,
                imageURL: nil),
        Lecture(id: "1",
                title: "Test 3",
                category: nil,
                mediaURL: Bundle.main.url(forResource: "Test-3", withExtension: "mp3")!,
                imageURL: nil)
    ]

    var longTestLectures = [
        Lecture(id: "1",
                title: "Test long mp3",
                category: nil,
                mediaURL: Bundle.main.url(forResource: "demoMP3", withExtension: "mp3")!,
                imageURL: nil),
        Lecture(id: "1",
                title: "Test long mp4",
                category: nil,
                mediaURL: Bundle.main.url(forResource: "demoMP4", withExtension: "mp4")!,
                imageURL: nil)
    ]

    var index = 0

    func nextLecture() async throws -> PlayerLecture? {

        let lectures = useShorts ? shortTestLectures : longTestLectures

        if index >= lectures.count {
            return nil

        } else {
            let lecture = lectures[index]
            index += 1
            return lecture
        }
    }
}
