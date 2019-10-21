//
//  BookCategoryApiHelper.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation

struct BookCategoryAPIClient {
    
    static let manager = BookCategoryAPIClient()
    
    func getCategory(completionHandler: @escaping (Result<[BookCategory], AppError>) -> () ) {
        
        NetworkManager.manager.performDataTask(withUrl: cateogryURL, httpMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                do {
                    let category = try BookCategory.getCategory(from: data)
                    guard let categoryUnwrapped = category else {completionHandler(.failure(.invalidJSONResponse));return
                    }
                    completionHandler(.success(categoryUnwrapped))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
        
    }
    var cateogryURL: URL {
        guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(Secrets.nytKey)") else {fatalError("Error: Invalid URL")}
        return url
    }
    
    private init() {}
    
}
