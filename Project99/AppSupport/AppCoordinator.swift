//
//  AppCoordinator.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    lazy var remoteDataManager: RemoteDataManager = {
        let dm = RemoteDataManagerImpl()
        return dm
    }()
    
    lazy var localDataManager: LocalDataManager = {
        let dm = LocalDataManagerImpl()
        return dm
    }()
    
    lazy var dataManager: DataManager = {
        let dm = DataManager(remoteDataManager: remoteDataManager, localDataManager: localDataManager)
        return dm
    }()
    
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        
        let stocksNavigationController = UINavigationController()
        let stocksCoordinator = StocksCoordinator(presenter: stocksNavigationController, stocksDataManager: dataManager)
        addChildCoordinator(coordinator: stocksCoordinator)
        stocksCoordinator.start()
        
        
        window.rootViewController = stocksNavigationController
        window.makeKeyAndVisible()
    }
    
    override func finish() {}
}
