import Foundation

extension AllCollectionVC: AllCollectionViewProtocol {

    func present(viewModel: ViewModel) {
        
        guard let view = self.view as? AllCollectionV else { return }
        
        for item in viewModel.items {
            print(item.title)
        }
        self.viewModel = viewModel
        
        view.collectionView.reloadData()
    }
}
