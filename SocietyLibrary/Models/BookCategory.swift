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
    
//    static func getWeather(from jsonData: Data) throws -> [DailyDatum]? {
//        let response = try JSONDecoder().decode(Weather.self, from: jsonData)
//        return response.daily.data
//
//    }
}

struct Category: Codable {
    
    let list_name: String
    let display_name: String
}

