//
//  BookCategory.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation


struct BookCategoryWrapper: Codable {



    
    let results: [Category]
    
    
    static func getCategory(from jsonData: Data) throws -> [Category]? {
        
        let response = try JSONDecoder().decode(BookCategoryWrapper.self, from: jsonData)
        
        return response.results
    }
    
}

struct Category: Codable {
    
    let list_name: String
    let display_name: String
    let list_name_encoded: String
}

