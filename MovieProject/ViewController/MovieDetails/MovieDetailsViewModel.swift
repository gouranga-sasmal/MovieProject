//
//  MovieDetailsViewModel.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import Foundation

class MovieDetailsViewModel: BaseViewModel {
    
    private let maxRatingValue: Double = 5.0
    
    let movie: VideoModel
    
    init(movie: VideoModel) {
        self.movie = movie
        super.init()
    }
    
    func getPosterURL() -> String? {
        return movie.poster
    }
    
    func getMoviewTitle() -> String? {
        return movie.title
    }
    
    func getPlot() -> String? {
        return movie.plot
    }
    
    func getCastAndCrew() -> String? {
        return movie.actors
    }
    
    func getReleaseDate() -> String? {
        return movie.released
    }
    
    func getGenre() -> String? {
        return movie.genre
    }
    
    func showRating() -> Bool {
        return !movie.ratings.isEmpty
    }
    
    /// Can show rating for the given index
    /// - Parameter index: <#index description#>
    /// - Returns: <#description#>
    func canShowRating(at index: Int) -> (show: Bool, ratingString: String, rating: Double) {
        // chcek the index
        guard (movie.ratings.count - 1) >= index else {
            // not valid index return false tuple
            return (false, "", 0.0)
        }
        let ratingObject = movie.ratings[index]
        let rater = "\(ratingObject.source ?? ""): \(ratingObject.value ?? "")"
        let rating = ratingObject.convertedRating(basedOn: maxRatingValue) ?? 0
        return (true, rater, rating )
    }
}
