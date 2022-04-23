import Foundation
import Entities

enum OutputEvent {
    case allData([AudioAsset])
}

protocol InteractorOutput {
    
    func present(output: OutputEvent)
}
