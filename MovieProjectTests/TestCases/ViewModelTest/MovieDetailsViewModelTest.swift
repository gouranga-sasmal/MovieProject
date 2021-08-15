//
//  MovieDetailsViewModelTest.swift
//  MovieProjectTests
//
//  Created by Gouranga Sasmal on 15/08/21.
//

import XCTest
@testable import MovieProject

class MovieDetailsViewModelTest: XCTestCase {
    
    var viewModel: MovieDetailsViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        guard let data = loadResource(file: "movies.json"),
              let videoList: [VideoModel] = VideoParser().parse(data)  else { return }
        
        self.viewModel = MovieDetailsViewModel(movie: videoList[0])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
    }

    func testRatingCount() {
        XCTAssertEqual(self.viewModel.showRating(), true)
    }
    
    func testMovieTitle() {
        XCTAssertEqual(self.viewModel.getMoviewTitle(), "Meet the Parents")
    }
    
    func testRatingText() {
        let ratingText = self.viewModel.canShowRating(at: 0)
        XCTAssertEqual(ratingText.rating, 3.5)
    }

}
