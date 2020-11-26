//
//  StocksDataManager.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

protocol StocksDataManager {
    func getStocks(completion: @escaping (Result<[Stock]?, Error>) -> Void)
}
