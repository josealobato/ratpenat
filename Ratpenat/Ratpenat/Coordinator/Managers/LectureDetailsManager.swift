import UIKit
import Coordinator
import LectureDetails
import RData

final class LectureDetailsManager: RequestCoordinatorManager {

    override func coordinate(from module: Coordinated, request: CoordinationRequest) {

        if case .showLectureDetails(let id) = request {

            let adapter = LectureDetailsAdapter(repository: LecturesRepositoryBuilder.shared)
            let lecturaDetailsVC = LectureDetailsBuilder.build(entityId: id,
                                                             services: adapter)
            parentCoordinator.navigationController?.pushViewController(lecturaDetailsVC,
                                                                       animated: true)
            parentCoordinator.managerDidFinish(self)
        }
    }
}
