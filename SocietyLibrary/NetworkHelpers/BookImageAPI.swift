//
//  BookImageAPI.swift
//  SocietyLibrary
//
//  Created by albert coelho oliveira on 10/22/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation

struct BookImageApi{
        
        static let manager = BookImageApi()
        
        func getBestSellers(category: String, completionHandler: @escaping (Result<[BookElement], AppError>) -> () ) {
            var bestSellerURL: URL {
                guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/current//\(category).json?api-key=\(Secrets.nytKey)") else {fatalError("Error: Invalid URL")}
                return url
                
            }
            NetworkManager.manager.performDataTask(withUrl: bestSellerURL, httpMethod: .get) { (result) in
                switch result {
                case .failure(let error):
                    completionHandler(.failure(error))
                    return
                case .success(let data):
                    do {
                        let bestSeller = try NYTImage.getBookImage(from: data)
                        guard let bookElement = bestSeller else {completionHandler(.failure(.invalidJSONResponse));return
                        }
                        completionHandler(.success(bookElement))
                    } catch {
                        completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                    }
                }
            }
            
        }

        
        private init() {}
        
    }


