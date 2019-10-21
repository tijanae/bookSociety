//
//  CategoryBestseller.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation

struct CategoryBestSeller: Codable {
    
    let results: [BestSeller]
    
    static func getBestSellers(from jsonData: Data) -> [CategoryBestSeller]? {
        
        return [CategoryBestSeller]()
    }
}

struct BestSeller: Codable {
    
    let display_name: String
    let weeks_on_list: Int
    let amazon_product_url: String
    let isbns: [Isbn]
    let book_details: [BookDetail]
    
}

struct Isbn: Codable {
    let isbn10: String
    let isbn13: String
}

struct BookDetail: Codable {
    let title: String
    let description: String
    let author: String
}
