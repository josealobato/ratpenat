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
        return ViewModel() // TODO: conversion.
    }
}
