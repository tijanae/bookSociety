//
//  BookInfo.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation

struct BookInfo: Codable {
    
    let items: [Item]
    
    static func getBookInfo(from jsonData: Data) throws -> [Item]? {
        
        let response = try JSONDecoder().decode(BookInfo.self, from: jsonData)
        
        return response.items
    
    }
}

struct Item: Codable {
    let volumeInfo: VolumeInfo
   
}

struct VolumeInfo: Codable {
    let imageLinks: ImageLink
}

struct ImageLink: Codable {
    let smallThumbnail: String
    let thumbnail: String
}
