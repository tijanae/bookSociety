//
//  NYTImage.swift
//  SocietyLibrary
//
//  Created by albert coelho oliveira on 10/22/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation

struct NYTImage: Codable {
    let results: Results
    static func getBookImage(from jsonData: Data) throws -> [BookElement]? {
        let response = try JSONDecoder().decode(NYTImage.self, from: jsonData)
        return response.results.books
    }
}

struct Results: Codable{
    let books: [BookElement]
}
struct BookElement: Codable {
    let book_image: String
    let rank: Int
    let weeks_on_list: Int
    let title: String
    let author: String
    let description: String
    let buy_links: [BuyLink]
    
}
struct BuyLink: Codable{
    let name: Name
    let url: String
}
enum Name: String, Codable {
   case amazon = "Amazon"
   case appleBooks = "Apple Books"
   case barnesAndNoble = "Barnes and Noble"
   case localBooksellers = "Local Booksellers"
}
