
//
//  BookInfoApiHelper.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation

struct BookInfoAPIClient {
    
    static let manager = BookInfoAPIClient()
    

    func getBookInfo(url: String, completionHandler: @escaping (Result<[Item], AppError>) -> () ) {
       
        var bookInfoURL: URL {
            guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(url)") else {fatalError("Error: Invalid URL")}
            return url
        }

        NetworkManager.manager.performDataTask(withUrl: bookInfoURL, httpMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                do {
                    let bookInfo = try BookInfo.getBookInfo(from: data)
                    guard let bookInfoUnwrapped = bookInfo else {completionHandler(.failure(.invalidJSONResponse));return
                    }
                    completionHandler(.success(bookInfoUnwrapped))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
        
    }
    private init() {}
    
}
