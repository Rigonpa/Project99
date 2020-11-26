//
//  StockDetailViewModel.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol StockDetailViewDelegate: class {
    func refreshTable()
}

class StockDetailViewModel {
    
    var sckAttributeCellViewModels = [SckAttributeCellViewModel]()
    
    weak var viewDelegate: StockDetailViewDelegate?
    
    let stock: Stock
    init(stock: Stock) {
        self.stock = stock
    }
    
    func viewDidLoad() {
        sckAttributeCellViewModels = [
            SckAttributeCellViewModel(position: 0, value: stock.name),
            SckAttributeCellViewModel(position: 1, value: String(stock.hot)),
            SckAttributeCellViewModel(position: 2, value: stock.ricCode),
            SckAttributeCellViewModel(position: 3, value: stock.category),
        ]
        
        viewDelegate?.refreshTable()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows() -> Int {
        return sckAttributeCellViewModels.count
    }

    func cellForRowAt(indexPath: IndexPath) -> SckAttributeCellViewModel? {
        if indexPath.row < sckAttributeCellViewModels.count {
            return sckAttributeCellViewModels[indexPath.row]
        } else {
            return nil
        }
    }
    
}
