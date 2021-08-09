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
    
    /// Get movie list based on category value
    /// - Parameters:
    ///   - filterCategory: <#filterCategory description#>
    ///   - movieList: <#movieList description#>
    ///   - value: <#value description#>
    /// - Returns: <#description#>
    private func filterdMovieList(using filterCategory: MovieFilterCategory, from movieList: [VideoModel], withSearchable value: String) -> [VideoModel] {
        
        let withCriteria: (VideoModel) -> Bool = { video in
            let vals = self.getValue(of: filterCategory, from: video)
            return vals.contains(value)
        }
        
        return movieList.filter(withCriteria)
    }
}

/*
class MovieListViewModel: MovieSearchableListViewModel {
    
//    public var reloadTableCompletion:((Bool)->Void)? = nil // to reload the tableview
    public var movieClickedCompletion:((VideoModel)->Void)? = nil // push to movie details
    
    private var movieListFetcher: MovieListFetchable? = nil // get movie list
    private var allMovies: [VideoModel] = [] // all movies
    private var movies: [VideoModel] = [] // filterd movies
    private var values: [String] = []
    
    
    private var tableState: TableViewUIState = .showAllFilters // assign to initial state
    
    func initiate() {
        
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
    
    /// Get number of rows
    /// - Returns: Int value
    func getNumberOfRows() -> Int {
        switch tableState {
        case .showAllFilters, .specificTo(_):
            return values.count
        default:
            return movies.count
        }
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
        switch tableState {
        case .showAllFilters:
            let categoryName: String = self.getCellModel(for: indexPath).lowercased()
            if let category = MovieFilterCategory(rawValue: categoryName) {
                self.tableState = TableViewUIState.specificTo(filterCategory: category)
                self.values = self.getAllValues(of: category, from: self.allMovies)
                self.values = Array(Set(self.values)).sorted()
                self.reloadTableCompletion?(true)
            }
        case .specificTo(let filterCategory):
            let value: String = self.getCellModel(for: indexPath)
            self.tableState = TableViewUIState.movieList(filterCategory: filterCategory, selectedValue: value)
            self.movies = filterdMovieList(using: filterCategory, from: self.allMovies, withSearchable: value)
            self.reloadTableCompletion?(true)
        case .movieList(_, _), .search(_):
            // push to movie details
            let selectedMovie = self.movies[indexPath.row]
            self.movieClickedCompletion?(selectedMovie)
            break
        }
    }
    
    /// Should show movie list or those category/their values
    /// - Returns: <#description#>
    func showMovieList() -> Bool {
        switch self.tableState {
        case .showAllFilters, .specificTo(_):
            return false
        default:
            return true
        }
    }
    
    //MARK: Private methods
    
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
    
    /// Get value of selected category from movie
    /// - Parameters:
    ///   - filterCategory: <#filterCategory description#>
    ///   - movie: <#movie description#>
    /// - Returns: <#description#>
    private func getValue(of filterCategory: MovieFilterCategory, from movie: VideoModel) -> [String] {
        
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
    
    /// Get movie list based on category value
    /// - Parameters:
    ///   - filterCategory: <#filterCategory description#>
    ///   - movieList: <#movieList description#>
    ///   - value: <#value description#>
    /// - Returns: <#description#>
    private func filterdMovieList(using filterCategory: MovieFilterCategory, from movieList: [VideoModel], withSearchable value: String) -> [VideoModel] {
        
        let withCriteria: (VideoModel) -> Bool = { video in
            let vals = self.getValue(of: filterCategory, from: video)
            return vals.contains(value)
        }
        
        return movieList.filter(withCriteria)
    }
}

//MARK: Search related methods
extension MovieListViewModel {
    
    func searchBarBeginEditing() {
        self.tableState = .search(string: "")
    }
    
    func searchBarEndEditing() {
        self.tableState = .showAllFilters
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
*/
