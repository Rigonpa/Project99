//
//  DataManager.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

class DataManager {
    
    var stocks = [Stock]()
    
    var remoteDataManager: RemoteDataManager?
    var localDataManager: LocalDataManager?
    init(remoteDataManager: RemoteDataManager?, localDataManager: LocalDataManager?) {
        self.remoteDataManager = remoteDataManager
        self.localDataManager = localDataManager
    }
}

extension DataManager: StocksDataManager {
    func getStocks(completion: @escaping (Result<[Stock]?, Error>) -> Void) {
        
        remoteDataManager?.getFavStocks(completion: {[weak self] (response) in
            switch response {
            case .success(let stocksIds):
                // Lets obtain each stock object by individual api calls:
                guard let ids = stocksIds else { return }
                DispatchQueue.global(qos: .userInteractive).async {[weak self] in
                    
                    let group = DispatchGroup()
                    
                    for index in 0...ids.count - 1{
                        group.enter()

                        self?.remoteDataManager?.getFavStock(id: ids[index], completion: { (response) in
                            switch response {
                            case .success(let successResponse):
                                guard let stock = successResponse else { return }
                                self?.stocks.append(stock)
                                group.leave()
                            case .failure(let error):
                                print(error.localizedDescription)
                                group.leave()
                            }
                        })
                    }
                
                    group.wait()
                    
                    DispatchQueue.main.async {[weak self] in
                        self?.saveStocksLocally()
                        completion(.success(self?.stocks))
                    }
                }
                
                completion(.success(self?.stocks))
                
            case .failure(_):
                // Offline. Need to retrieve persisted stock objects
                let stocksFromLocalDatabase = self?.localDataManager?.fetchFavStocks()
                completion(.success(stocksFromLocalDatabase))
            }
        })
    }
    
    func saveStocksLocally() {
        localDataManager?.removePreviousStocks()
        for index in 0...stocks.count - 1{
            localDataManager?.saveStock(stock: stocks[index])
        }
    }
}
