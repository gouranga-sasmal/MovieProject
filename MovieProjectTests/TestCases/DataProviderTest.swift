//
//  DataProviderTest.swift
//  MovieProjectTests
//
//  Created by Gouranga Sasmal on 14/08/21.
//

import XCTest
@testable import MovieProject

class DataProviderTest: XCTestCase {
    
    var dataProvider: FileDataProvider!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.dataProvider = FileDataProvider(fileName: "movies.json")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.dataProvider = nil
    }
    
    //MARK: Test for data 
    
    func testForData() {
        dataProvider.fetchData { (data, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
        }
    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
