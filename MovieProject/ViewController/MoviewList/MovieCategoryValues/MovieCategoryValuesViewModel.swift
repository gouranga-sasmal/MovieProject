//
//  MovieCategoryValuesViewModel.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 09/08/21.
//

import Foundation

class MovieCategoryValuesViewModel: MovieSearchableListViewModel {
    
    public var categoryValueClickedCompletion:((MovieFilterCategory, String, [VideoModel])->Void)? = nil // push to movie details
    
    private let category: MovieFilterCategory
    
    init(category: MovieFilterCategory, and movies: [VideoModel]) {
        self.category = category
        super.init()
        self.allMovies = movies
    }
    
    override func initiate() {
        
        // get all values of the specific category
        let allValues = self.getAllValues(of: category, from: self.allMovies)
        
        // remove duplicaet and sort these values
        self.values = Array(Set(allValues)).sorted()
        
        // reload table
        self.reloadTableCompletion?(true)
        
    }
    
    override func tableViewDidTap(at indexPath: IndexPath) {
        let selectedValue: String = self.getCellModel(for: indexPath)
        self.categoryValueClickedCompletion?(self.category, selectedValue, allMovies)
    }
    

    /// Get all values of selected category from moviewList
    /// - Parameters:
    ///   - filterCategory: <#filterCategory description#>
    ///   - movieList: <#movieList description#>
    /// - Returns: <#description#>
    private func getAllValues(of filterCategory: MovieFilterCategory, from movieList: [VideoModel]) -> [String] {
        return movieList
            .map { self.getValue(of: filterCategory, from: $0) }
            .flatMap { $0 }
    }
    
}
