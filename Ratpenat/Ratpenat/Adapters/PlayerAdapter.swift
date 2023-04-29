import Foundation
import Player
import Entities
import Foundation

class PlayerAdapter: PlayerServiceInterface {

    func nextLecture() async throws -> Lecture? {

//        let demoFileLocation = Bundle.main.url(forResource: "demoMP4", withExtension: "mp4")!
        let demoFileLocation = Bundle.main.url(forResource: "demoMP3", withExtension: "mp3")!

        let lecture = Lecture(id: "1", title: "demoMP3", location: demoFileLocation)

        return lecture
    }
}
