import Foundation

enum InputEvent {
    case loadInitialData
}

protocol InteractorInput {
    func performAction(input: InputEvent)
}
