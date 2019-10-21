//
//  BestsellerApiHelper.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation

struct BestsellerAPIClient {
    
    static let manager = BestsellerAPIClient()
    
    func getBestSellers(completionHandler: @escaping (Result<[CategoryBestSeller], AppError>) -> () ) {
        
        NetworkManager.manager.performDataTask(withUrl: bestSellerURL, httpMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                do {
                    let bestSeller = try CategoryBestSeller.getBestSellers(from: data)
                    guard let bestsellerUnwrapped = bestSeller else {completionHandler(.failure(.invalidJSONResponse));return
                    }
                    completionHandler(.success(bestsellerUnwrapped))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
        
    }
    var bestSellerURL: URL {
        guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists.json?api-key=\(Secrets.nytKey)&list=Hardcover-Fiction") else {fatalError("Error: Invalid URL")}
        return url
    }
    
    private init() {}
    
}
