//
//  MovieListFetchable.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import Foundation

/// Fetch list of movies
protocol MovieListFetchable: VideoListFetchable {
    func fetchMovieList(completion: @escaping (_ isSuccess: Bool,_ movies: [VideoModel]) -> Void)
}

extension MovieListFetchable {
    func fetchMovieList(completion: @escaping (_ isSuccess: Bool,_ movies: [VideoModel]) -> Void) {
        // fetch video
        self.fetchVideoList { (isSuccess, videoModels) in
            // filter movie type
            let movies = videoModels.filter { $0.type == VideoType.movie }
            completion(isSuccess, movies)
        }
    }
}
