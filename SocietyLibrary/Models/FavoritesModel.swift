//
//  FavoritesModel.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import Foundation

struct FavoriteBooks: Codable {
    let imageName: String
    let imageData: Data
    let summary: String
    let amazonURL: String
    let weeksOn: Int
}
