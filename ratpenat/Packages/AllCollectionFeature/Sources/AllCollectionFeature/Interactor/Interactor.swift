import Foundation

final class Interactor {
    
    let dataLink: AllCollectionFeatureDataLink
    let output: InteractorOutput
    
    init(dataLink: AllCollectionFeatureDataLink,
         output: InteractorOutput) {
        self.dataLink = dataLink
        self.output = output
    }
}

extension Interactor: InteractorInput {
    
    func performAction(input: InputEvent) {
        
        switch input {
        case .loadInitialData:
            let allAssets = dataLink.allAudioAssets()
            output.present(output: .allData(allAssets))
        }
    }
}
