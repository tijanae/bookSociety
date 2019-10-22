//
//  BookPersistenceManager.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation

struct BookPersistenceManager {
    
    private init() {}
    
    static let manager = BookPersistenceManager()
    
    private let persistenceHelper = PersistenceHelper<FavoriteBooks>(fileName: "favedBooks.plist")
    
    func saveFavorites(bookData: FavoriteBooks) throws {
        try persistenceHelper.save(newElement: bookData)
    }
    
    func getFavorites() throws -> [FavoriteBooks] {
        return try persistenceHelper.getObjects()
    }
    
    func delete(element: [FavoriteBooks], atIndex: Int) throws {
        try persistenceHelper.delete(elements: element, index: atIndex)
    }
}


