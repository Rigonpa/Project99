//
//  RemoteDataManagerImpl.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import Foundation

let apiURL = "https://challenge.ninetynine.com"

class RemoteDataManagerImpl: RemoteDataManager {
    var baseURL: URL {
        guard let baseURL = URL(string: apiURL) else {
            fatalError("URL not valid")
        }
        return baseURL
    }
    
    func getFavStocks(completion: @escaping (Result<[String]?, Error>) -> Void) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let url = baseURL.appendingPathComponent("/favorites")
        
        let task = session.dataTask(with: url) { (data, response, error) in // Background queue
            
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 200, let data = data {
                do {
                    let getStocksResponse = try JSONDecoder().decode(StocksResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(getStocksResponse.result))
                    }
                } catch (let error) {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func getFavStock(id: String, completion: @escaping (Result<Stock?, Error>) -> Void) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let url = baseURL.appendingPathComponent("/favorites/\(id)")
        
        let task = session.dataTask(with: url) { (data, response, error) in // Background queue
            
            let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 200, let data = data {
                do {
                    let stock = try JSONDecoder().decode(Stock.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(stock))
                    }
                } catch (let error) {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
