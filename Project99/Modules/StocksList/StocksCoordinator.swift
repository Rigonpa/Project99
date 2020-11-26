//
//  StocksCoordinator.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class StocksCoordinator: Coordinator {
    
    let presenter: UINavigationController
    let stocksDataManager: StocksDataManager
    init(presenter: UINavigationController, stocksDataManager: StocksDataManager) {
        self.presenter = presenter
        self.stocksDataManager = stocksDataManager
    }
    
    override func start() {
        let stocksViewModel = StocksViewModel(dataManager: stocksDataManager)
        let stocksViewController = StocksViewController(viewModel: stocksViewModel)
        
        // Delegates
        stocksViewModel.viewDelegate = stocksViewController
        stocksViewModel.coordinatorDelegate = self
        
        presenter.pushViewController(stocksViewController, animated: true)
    }
    
    override func finish() {}
}

extension StocksCoordinator: StocksCoordinatorDelegate {
    func stockSelected(stock: Stock) {
        let stockDetailViewModel = StockDetailViewModel(stock: stock)
        let stockDetailViewController = StockDetailViewController(viewModel: stockDetailViewModel)
        
        stockDetailViewModel.viewDelegate = stockDetailViewController
        
        presenter.pushViewController(stockDetailViewController, animated: true)
    }
}
