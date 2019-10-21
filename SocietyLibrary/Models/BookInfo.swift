//
//  BookInfo.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation

struct BookInfo: Codable {
    
    let items: [BookData]
    
    static func getBookInfo(from jsonData: Data) -> [BookInfo]? {
        
        return [BookInfo]()
    }
}

struct BookData: Codable {
    let imageLinks: ImageLink
}

struct ImageLink: Codable {
    let smallThumbnail: String
    let thumbnail: String
}
