//
//  StocksViewModel.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol StocksCoordinatorDelegate: class {
    func stockSelected(stock: Stock)
}

protocol StocksViewDelegate: class {
    func refreshTable()
}

class StocksViewModel {
    
    var stockCellViewModels = [StockCellViewModel]()

    weak var viewDelegate: StocksViewDelegate?
    weak var coordinatorDelegate: StocksCoordinatorDelegate?

    let dataManager: StocksDataManager
    init(dataManager: StocksDataManager) {
        self.dataManager = dataManager
    }

    func viewDidLoad() {
        dataManager.getStocks {[weak self] response in
            switch response {
            case .success(let stocksResponse):
                guard let stocks = stocksResponse else { return }
                self?.stockCellViewModels = stocks.map { stock -> StockCellViewModel in
                    let stockCellViewModel = StockCellViewModel(stock: stock)
                    stockCellViewModel.cellDelegate = self
                    return stockCellViewModel
                }
                self?.viewDelegate?.refreshTable()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func didSelectRowAt(indexPath: IndexPath) {
        coordinatorDelegate?.stockSelected(stock: stockCellViewModels[indexPath.row].stock)
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows() -> Int {
        return stockCellViewModels.count
    }

    func cellForRowAt(indexPath: IndexPath) -> StockCellViewModel? {
        if indexPath.row < stockCellViewModels.count {
            return stockCellViewModels[indexPath.row]
        } else {
            return nil
        }
    }
}

extension StocksViewModel: StockDetailCellViewModelDelegate {
    func deleteButtonPressed(stock: Stock) {
        stockCellViewModels.removeAll { (stockCellViewModel) -> Bool in
            stockCellViewModel.stock.name == stock.name
        }
        
        viewDelegate?.refreshTable()
    }
}
