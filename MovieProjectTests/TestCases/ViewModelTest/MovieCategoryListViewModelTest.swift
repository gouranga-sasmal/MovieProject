//
//  MovieCategoryListViewModelTest.swift
//  MovieProjectTests
//
//  Created by Gouranga Sasmal on 14/08/21.
//

import XCTest
@testable import MovieProject

class MovieCategoryListViewModelTest: XCTestCase {
    
    // MARK: - Properties

    var viewModel: MovieCategoryListViewModel!
    
    // MARK: - Set Up & Tear Down

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.viewModel = MovieCategoryListViewModel()
        self.viewModel.initiate()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
    }
    
    func testValues() {
        XCTAssertEqual(self.viewModel.values.count, 4)
    }
    
    func testNumberOfRows() {
        XCTAssertEqual(self.viewModel.getNumberOfRows(), 4)
        
        self.viewModel.searchMode = .on
        XCTAssertEqual(self.viewModel.getNumberOfRows(), 0)
        
        self.viewModel.searchMode = .off
        XCTAssertEqual(self.viewModel.getNumberOfRows(), 4)
    }
    
    func testShowMovieList() {
        XCTAssertFalse(self.viewModel.showMovieList())
        
        self.viewModel.searchMode = .on
        XCTAssertTrue(self.viewModel.showMovieList())
        
        self.viewModel.searchMode = .off
        XCTAssertFalse(self.viewModel.showMovieList())
    }
    
    func testSearchMode() {
        XCTAssertFalse(self.viewModel.searchMode == .on)
        
        self.viewModel.searchBarBeginEditing()
        XCTAssertTrue(self.viewModel.searchMode == .on)
        
        self.viewModel.searchBarEndEditing()
        XCTAssertTrue(self.viewModel.searchMode == .off)
    }
    
    func testSearchMovies() {
        self.viewModel.searchMovies(with: "Spy")
        XCTAssertEqual(self.viewModel.movies.count, 2)
        
        self.viewModel.searchMovies(with: "brad")
        XCTAssertEqual(self.viewModel.movies.count, 1)
        
        self.viewModel.searchMovies(with: "Scott")
        XCTAssertEqual(self.viewModel.movies.count, 2)
        
        self.viewModel.searchMovies(with: "dram")
        XCTAssertEqual(self.viewModel.movies.count, 6)
        
    }
}
