//
//  pruebaNetworking.swift
//  pruebaHeroTests
//
//  Created by Horacio Guzman on 10/25/18.
//  Copyright © 2018 hero. All rights reserved.
//

import XCTest

@testable import pruebaHero

class pruebaNetworking: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        LocationService.shared.mockLastLocation(lat: 39.996563, lng: -75.143649)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPruebaCargaInicial(){
        
        NetworkService.loadVenues { (error, venuesReturned) in
            XCTAssertNotNil(venuesReturned)
        }
         
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            NetworkService.loadCategories(completion: { (categories) in
                XCTAssertNotNil(categories)
            })
        }
    }

}
