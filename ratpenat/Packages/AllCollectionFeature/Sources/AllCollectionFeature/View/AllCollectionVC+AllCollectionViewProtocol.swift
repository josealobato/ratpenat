import Foundation

extension AllCollectionVC: AllCollectionViewProtocol {

    func present(viewModel: ViewModel) {
        
        for item in viewModel.items {
            print(item.title)
        }
    }
}
