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
}

/*
 private init() {}
    static let manager = CityImagePersistenceManager()
    
    private let persistenceHelper = PersistenceHelper<SavedCityImage>(fileName: "cityImages.plist")
    
    func savePhoto(photo: SavedCityImage) throws {
        try persistenceHelper.save(newElement: photo)
    }
    
    func getPhoto() throws -> [SavedCityImage] {
        return try persistenceHelper.getObjects()
    }
 */
