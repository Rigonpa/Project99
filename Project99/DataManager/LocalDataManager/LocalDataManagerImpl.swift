//
//  LocalDataManagerImpl.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit
import CoreData

class LocalDataManagerImpl: LocalDataManager {
    lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError()}
        return appDelegate.persistentContainer.viewContext
    }()
    
    var stockEntity = "FavStock"
    
    func saveStock(stock: Stock) {
        guard let entity = NSEntityDescription.entity(forEntityName: stockEntity, in: context) else { return }
        let favStock = FavStock(entity: entity, insertInto: context)
        favStock.name = stock.name
        favStock.hot = Int16(stock.hot)
        favStock.ricCode = stock.ricCode
        favStock.category = stock.category
        
        try? context.save()
    }
    
    func fetchFavStocks() -> [Stock]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: stockEntity)
        guard let favStocks = try? context.fetch(fetchRequest) as? [FavStock] else { return nil }
        let stocks = favStocks.map {
            Stock(name: $0.name ?? "", hot: Int($0.hot), ricCode: $0.ricCode ?? "", category: $0.category ?? "")
        }
        return stocks
    }
    
    func removePreviousStocks() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: stockEntity)
        let stocksToDelete = try? context.fetch(fetchRequest)
        stocksToDelete?.forEach { context.delete($0) }
        
        try? context.save()
    }
}
