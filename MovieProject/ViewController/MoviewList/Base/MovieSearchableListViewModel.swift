//
//  MovieSearchableListViewModel.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 09/08/21.
//

import Foundation

enum SearchMode {
    case on, off
}

protocol MovieSearchableListViewModelProtocol: class {
    var reloadTableCompletion:((Bool)->Void)? { get set} // to reload the tableview
    var movieClickedCompletion:((VideoModel)->Void)? { get set} // push to movie details
    var searchMode: SearchMode { get }

    func initiate()
    func getNumberOfRows() -> Int
    func getCellModel(for indexPath: IndexPath) -> String
    func getCellModel(for indexPath: IndexPath) -> VideoModel
    func tableViewDidTap(at indexPath: IndexPath)
    
    func searchBarBeginEditing()
    func searchBarEndEditing()
    func searchMovies(with keyword: String)
}

enum SearchableCategory {
    case title
    case actor
    case genre
    case director
}

enum MovieFilterCategory: String, CaseIterable {
    case year
    case genre
    case directors
    case actors
}




class MovieSearchableListViewModel: BaseViewModel, MovieSearchableListViewModelProtocol {
    var searchMode: SearchMode = .off
    
    public var reloadTableCompletion:((Bool)->Void)? = nil // to reload the tableview
    public var movieClickedCompletion:((VideoModel)->Void)? = nil // push to movie details
    
    public var allMovies: [VideoModel] = [] // all movies
    public var movies: [VideoModel] = [] // filterd movies
    public var values: [String] = []
    
    
    func initiate() {
        
    }
    
    /// Get number of rows
    /// - Returns: Int value
    func getNumberOfRows() -> Int {
        return searchMode == SearchMode.on ? movies.count : values.count
    }
    
    /// Get the cell model by which cell nformation will be populate
    /// - Parameter indexPath: Indexpath
    /// - Returns: <#description#>
    func getCellModel(for indexPath: IndexPath) -> String {
        return values[indexPath.row]
    }
    
    /// Get the cell model by which cell nformation will be populate
    /// - Parameter indexPath: <#indexPath description#>
    /// - Returns: <#description#>
    func getCellModel(for indexPath: IndexPath) -> VideoModel {
        return movies[indexPath.row]
    }
    
    /// Call this function after movie selection
    /// - Parameter indexPath: <#indexPath description#>
    func tableViewDidTap(at indexPath: IndexPath) {
//        if searchMode == .off {
//            let categoryName: String = self.getCellModel(for: indexPath).lowercased()
//            if let category = MovieFilterCategory(rawValue: categoryName) {
//
//            }
//        } else {
//            // search mode on
//            let selectedMovie = self.movies[indexPath.row]
//            self.movieClickedCompletion?(selectedMovie)
//        }
//        switch tableState {
//        case .showAllFilters:
//            let categoryName: String = self.getCellModel(for: indexPath).lowercased()
//            if let category = MovieFilterCategory(rawValue: categoryName) {
//                self.tableState = TableViewUIState.specificTo(filterCategory: category)
//                self.values = self.getAllValues(of: category, from: self.allMovies)
//                self.values = Array(Set(self.values)).sorted()
//                self.reloadTableCompletion?(true)
//            }
//        case .specificTo(let filterCategory):
//            let value: String = self.getCellModel(for: indexPath)
//            self.tableState = TableViewUIState.movieList(filterCategory: filterCategory, selectedValue: value)
//            self.movies = filterdMovieList(using: filterCategory, from: self.allMovies, withSearchable: value)
//            self.reloadTableCompletion?(true)
//        case .movieList(_, _), .search(_):
//            // push to movie details
//            let selectedMovie = self.movies[indexPath.row]
//            self.movieClickedCompletion?(selectedMovie)
//            break
//        }
    }
    
    /// Should show movie list or those category/their values
    /// - Returns: <#description#>
    func showMovieList() -> Bool {
        return self.searchMode == .on
    }
    
    //MARK: Private methods
    
    
    /// Get value of selected category from movie
    /// - Parameters:
    ///   - filterCategory: <#filterCategory description#>
    ///   - movie: <#movie description#>
    /// - Returns: <#description#>
    public func getValue(of filterCategory: MovieFilterCategory, from movie: VideoModel) -> [String] {
        
        let categoryValuesOf: (VideoModel) -> [String] = { video in
            switch filterCategory {
            case .year:
                return [video.year?.trim() ?? ""]
            case .directors:
                return [video.director?.trim() ?? ""]
            case .actors:
                return video.actors?.split(separator: ",").map { String($0).trim() } ?? []
            case .genre:
                return video.genre?.split(separator: ",").map { String($0).trim() } ?? []
            }
        }
        
        return categoryValuesOf(movie)
    }
}


//MARK: Search related methods

extension MovieSearchableListViewModel {
    
    func searchBarBeginEditing() {
        self.searchMode = .on
    }
    
    func searchBarEndEditing() {
        self.searchMode = .off
        self.reloadTableCompletion?(true)
    }
    
    func searchMovies(with keyword: String) {
        self.movies = self.search(from: self.allMovies, with: keyword)
        self.reloadTableCompletion?(true)
    }
    
    /// Search from movies title/genre/director/actor with search keyword
    /// - Parameters:
    ///   - movies: <#movies description#>
    ///   - keyword: <#keyword description#>
    /// - Returns: <#description#>
    private func search(from movies: [VideoModel], with keyword: String) -> [VideoModel] {
        let shouldInclude = self.shouldInclude(search: keyword)
        return movies.filter(shouldInclude)
    }
    
    private func shouldInclude(search: String) -> (VideoModel) -> Bool {
        let searchedStr = search.lowercased()
        return { videoModel in
            return self.shouldInclude(movie: videoModel, with: searchedStr)
        }
    }
    
    /// Should we need to show the movie
    /// - Parameters:
    ///   - movie: <#movie description#>
    ///   - search: <#search description#>
    /// - Returns: <#description#>
    private func shouldInclude(movie: VideoModel, with search: String) -> Bool {
        
        let isMatchedWith: (String?) -> Bool = { value in
            print(value)
            return value?.lowercased().contains(search) ?? false
        }
        
        if isMatchedWith(movie.title) {
            return true
        }
        
        if isMatchedWith(movie.director) {
            return true
        }
        
        if isMatchedWith(movie.actors) {
            return true
        }
        
        if isMatchedWith(movie.genre) {
            return true
        }
        
        return false
    }
    
}
