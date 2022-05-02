import UIKit
import Entities

final class Presenter: InteractorOutput {
    weak var view: AllCollectionViewProtocol?
    
    func present(output: OutputEvent) {
        
        guard case let .allData(assets) = output else { return }
        view?.present(viewModel: ViewModel.from(assets))
    }
}

extension ViewModel {
    
    static func from(_ assets: [AudioAsset]) -> ViewModel {
        
        let durationString = "13m"
        let items = assets.map {ViewModel.Item(id: $0.id,
                                               title: $0.title,
                                               subject: $0.subject.name,
                                               duration: durationString) }
        return ViewModel(items: items)
    }
}
