//
//  RatingTest.swift
//  MovieProjectTests
//
//  Created by Gouranga Sasmal on 14/08/21.
//

import XCTest

@testable import MovieProject

class RatingTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testRating() {
        let rating1 = Rating(source: "Internet Movie Database", value: "8.1/10")
        let rating2 = Rating(source: "Rotten Tomatoes", value: "96%")
        let rating3 = Rating(source: "Metacritic", value: "87/100")
        
        let totalNumber1: Double = 10
        
        XCTAssertEqual(rating1.convertedRating(basedOn: totalNumber1), 8.1)
        XCTAssertEqual(rating2.convertedRating(basedOn: totalNumber1), 9.6)
        XCTAssertEqual(rating3.convertedRating(basedOn: totalNumber1), 8.7)
        
        let totalNumber2: Double = 50
        
        XCTAssertEqual(rating1.convertedRating(basedOn: totalNumber2), 40.5)
        XCTAssertEqual(rating2.convertedRating(basedOn: totalNumber2), 48)
        XCTAssertEqual(rating3.convertedRating(basedOn: totalNumber2), 43.5)
        
        let rating4 = Rating(source: "Internet Movie Database", value: "500")
        let rating5 = Rating(source: "Rotten Tomatoes", value: "0")
        let rating6 = Rating(source: "Metacritic", value: "87/0")
        
        XCTAssertNil(rating4.convertedRating(basedOn: totalNumber1))
        XCTAssertNil(rating5.convertedRating(basedOn: totalNumber1))
        XCTAssertNil(rating6.convertedRating(basedOn: totalNumber1))
        
        
        let rating7 = Rating(source: nil, value: "8/10")
        let rating8 = Rating(source: "Rotten Tomatoes", value: nil)
        let rating9 = Rating(source: nil, value: nil)
        
        XCTAssertNotNil(rating7.convertedRating(basedOn: totalNumber1))
        XCTAssertNil(rating8.convertedRating(basedOn: totalNumber1))
        XCTAssertNil(rating9.convertedRating(basedOn: totalNumber1))
    }

}
