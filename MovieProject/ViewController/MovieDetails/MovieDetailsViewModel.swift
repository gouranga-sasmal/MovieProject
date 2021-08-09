//
//  MovieDetailsViewModel.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import Foundation

class MovieDetailsViewModel: BaseViewModel {
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
    
    func getRating() -> String? {
        let rating = movie.ratings
            .map { "\($0.source ?? ""): \($0.value ?? "")"}
            .joined(separator: "\n")
        return rating
    }
}
