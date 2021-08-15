//
//  MovieListViewModel.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import Foundation

class MovieListViewModel: MovieSearchableListViewModel {
    
    private let category: MovieFilterCategory
    private let selectedValue: String
    
    init(category: MovieFilterCategory, value: String, and movies: [VideoModel]) {
        self.category = category
        self.selectedValue = value
        super.init()
        self.allMovies = movies
    }
    
    override func initiate() {
        self.movies = filterdMovieList(using: category, from: self.allMovies, withSearchable: selectedValue)
        self.reloadTableCompletion?(true)
    }
    
    func getTitleValue() -> String {
        return selectedValue
    }
    
    override func showMovieList() -> Bool {
        // this list will always show movie list
        return true
    }
    
    override func getNumberOfRows() -> Int {
        return movies.count
    }
    
    /// Get movie list based on category value
    /// - Parameters:
    ///   - filterCategory: <#filterCategory description#>
    ///   - movieList: <#movieList description#>
    ///   - value: <#value description#>
    /// - Returns: <#description#>
    private func filterdMovieList(using filterCategory: MovieFilterCategory, from movieList: [VideoModel], withSearchable value: String) -> [VideoModel] {
        
        let withCriteria: (VideoModel) -> Bool = { video in
            // get value of selected category from VideoModel
            let vals = self.getValue(of: filterCategory, from: video)
            // check if its contain our desird value or not
            return vals.contains(value)
        }
        // filter movie list
        return movieList.filter(withCriteria)
    }
    
    override func reloadtableAfterSearchCancel() {
        self.movies = filterdMovieList(using: category, from: self.allMovies, withSearchable: selectedValue)
        self.reloadTableCompletion?(true)
    }
}
