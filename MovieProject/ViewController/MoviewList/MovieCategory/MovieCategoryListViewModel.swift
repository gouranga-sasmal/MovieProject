//
//  MovieCategoryListViewModel.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 09/08/21.
//

import Foundation


class MovieCategoryListViewModel: MovieSearchableListViewModel {
    
    // tableview clicked completion with category and all Movie list
    public var tableClickedCompletion:((MovieFilterCategory, [VideoModel])->Void)? = nil
    
    private var movieListFetcher: MovieListFetchable? = nil // get movie list
    
    override func initiate() {
        super.initiate()
        
        // get the movie list using file.
        //If you wants movie lsit from network, you need to just conform MovieListFetchable protocol to that any Class/struct and asssign its object
        self.movieListFetcher = DataManager(fileName: "movies.json")
        
        // show the filetr category
        self.values = MovieFilterCategory.allCases.map { $0.rawValue.capitalized }
        
        // fetch movie list
        self.movieListFetcher?.fetchMovieList(completion: { (isSuccess, videos) in
            self.allMovies = videos
        })
    }
        
    override func tableViewDidTap(at indexPath: IndexPath) {
        guard searchMode == .off else {
            // if search is on the obviously tap will be on movie cell (TODO: check for empty )
            super.tableViewDidTap(at: indexPath)
            return
        }
        // get the cell value and convert it to category
        let categoryName: String = self.getCellModel(for: indexPath).lowercased()
        if let category = MovieFilterCategory(rawValue: categoryName) {
            self.tableClickedCompletion?(category, allMovies)
        }
    }
}
