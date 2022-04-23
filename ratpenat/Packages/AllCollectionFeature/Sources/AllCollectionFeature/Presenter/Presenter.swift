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
        let items = assets.map {ViewModel.Item(id: $0.id, title: $0.title) }
        return ViewModel(items: items)
    }
}
