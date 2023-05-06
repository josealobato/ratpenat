import Foundation
import Player
import Entities
import Foundation

class PlayerAdapter: PlayerServiceInterface {

    let useShorts = true

    var shortTestLectures = [
        Lecture(id: "1", title: "Test 1", location: Bundle.main.url(forResource: "Test-1", withExtension: "mp3")!),
        Lecture(id: "1", title: "Test 2", location: Bundle.main.url(forResource: "Test-2", withExtension: "mp3")!),
        Lecture(id: "1", title: "Test 3", location: Bundle.main.url(forResource: "Test-3", withExtension: "mp3")!)
    ]

    var longTestLectures = [
        Lecture(id: "1", title: "Test long mp3", location: Bundle.main.url(forResource: "demoMP3", withExtension: "mp3")!),
        Lecture(id: "1", title: "Test long mp4", location: Bundle.main.url(forResource: "demoMP4", withExtension: "mp4")!)
    ]

    var index = 0

    func nextLecture() async throws -> Lecture? {

        var lectures = useShorts ? shortTestLectures : longTestLectures

        if index >= lectures.count {
            return nil

        } else {
            let lecture = lectures[index]
            index += 1
            return lecture
        }
    }
}
