//
//  DataManagerTest.swift
//  MovieProjectTests
//
//  Created by Gouranga Sasmal on 14/08/21.
//

import XCTest
@testable import MovieProject

class DataManagerTest: XCTestCase {
    
    var dataManager: DataManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print("setUpWithError")
        self.dataManager = DataManager(fileName: "movies.json")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        print("tearDownWithError")
        self.dataManager = nil
    }
    
    func testVideos() {
        let provider = FileDataProvider(fileName: self.dataManager.fileName)
        let parser = VideoParser()
        
        XCTAssertEqual(provider.fileName, "movies.json")
        
        self.dataManager.fetchVideos(from: provider, parseUsing: parser) { (success: Bool, list: [VideoModel]) in
            XCTAssertTrue(success)
            XCTAssertEqual(list.count, 19)
        }
    }
    
    func testVideoListCount() {
        self.dataManager.fetchVideoList { (success, videoModels) in
            XCTAssertEqual(videoModels.count, 19)
            XCTAssertTrue(success)
        }
    }
    
    func testVideoType() {
        self.dataManager.fetchVideoList { (_, videoModels) in
            // check if contains only Movie type or not
            let movieCount = videoModels.filter { $0.type == VideoType.movie }.count
            let seriesCount = videoModels.filter { $0.type == VideoType.series }.count
           
            XCTAssertEqual(movieCount, 15)
            XCTAssertEqual(seriesCount, 4)
        }
    }
    
    func testMovieListCount() {
        self.dataManager.fetchMovieList { (success, videoModels) in
            XCTAssertEqual(videoModels.count, 15)
            XCTAssertTrue(success)
        }
    }
    
    func testMovieType() {
        
        self.dataManager.fetchMovieList { (_, videoModels) in
            // check if contains only Movie type or not
            let isAllMovieType = videoModels.reduce(true) { (result, videoModel) -> Bool in
                return result && videoModel.type == VideoType.movie
            }
            XCTAssertTrue(isAllMovieType)
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
