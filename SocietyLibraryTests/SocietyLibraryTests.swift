//
//  SocietyLibraryTests.swift
//  SocietyLibraryTests
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import XCTest
@testable import SocietyLibrary

class SocietyLibraryTests: XCTestCase {

    func testBookCategoryFromJSON() {
        
        
        let testBundle = Bundle(for: type(of: self))
        guard let pathToData = testBundle.path(forResource: "BookCategory", ofType: "json") else { XCTFail("Couldn't find json file")
            return}
        
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            let cateogry = try BookCategoryWrapper.getCategory(from: data)
            
            XCTAssert(cateogry != nil, "We couldn't get those categories")
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testCategoryBestsellerFromJSON() {
        
        let testBundle = Bundle(for: type(of: self))
               guard let pathToData = testBundle.path(forResource: "CategoryBestseller", ofType: "json") else { XCTFail("Couldn't find json file")
                   return}
               
               let url = URL(fileURLWithPath: pathToData)
               do {
                   let data = try Data(contentsOf: url)
                let cateogry = try CategoryBestSeller.getBestSellers(from: data)
                   
                   XCTAssert(cateogry != nil, "We couldn't get those best sellers")
               } catch {
                   XCTFail(error.localizedDescription)
               }
        
    }
    
    func testBookInfoFromJSON() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let pathToData = testBundle.path(forResource: "BookInfo", ofType: "json") else {
            XCTFail("Could not find json file")
        return}
        
        let url = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: url)
            let category = try BookInfo.getBookInfo(from: data)
            
            XCTAssert(category != nil, "We couldnt get the Image URLS")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    
}
