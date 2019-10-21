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
    
    
    
//    func testWeatherModelFromJSON() {
//        guard let path = Bundle.main.path(forResource: "Weather", ofType: "json") else {XCTFail(); return}
//        let urlFromFile = URL(fileURLWithPath: path)
//        do {
//            let data = try Data(contentsOf: urlFromFile)
//            guard let weatherData = try Weather.getWeather(from: data) else {XCTFail(); return}
//            print(weatherData.count)
//            XCTAssert(weatherData.count > 0)
//
//        } catch {
//            XCTFail()
//            print(error)
//        }
//
//    }
    
}
