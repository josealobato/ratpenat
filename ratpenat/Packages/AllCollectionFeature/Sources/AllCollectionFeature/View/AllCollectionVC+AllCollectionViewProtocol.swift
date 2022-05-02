import UIKit

extension AllCollectionVC: AllCollectionViewProtocol {

    func present(viewModel: ViewModel) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, ViewModel.Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
