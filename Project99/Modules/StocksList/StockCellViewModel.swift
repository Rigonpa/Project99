//
//  StockCellViewModel.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol StockDetailCellViewModelDelegate: class {
    func deleteButtonPressed(stock: Stock)
}

class StockCellViewModel {
    
    weak var cellDelegate: StockDetailCellViewModelDelegate?
    
    let stock: Stock
    init(stock: Stock) {
        self.stock = stock
    }
    
    func deleteButtonPressed() {
        cellDelegate?.deleteButtonPressed(stock: stock)
    }
}
