//
//  MovieListFetchable.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import Foundation

protocol MovieListFetchable: VideoListFetchable {
    func fetchMovieList(completion: @escaping (_ isSuccess: Bool,_ movies: [VideoModel]) -> Void)
}

extension MovieListFetchable {
    func fetchMovieList(completion: @escaping (_ isSuccess: Bool,_ movies: [VideoModel]) -> Void) {
        self.fetchVideoList { (isSuccess, videoModels) in
            let movies = videoModels.filter { $0.type == VideoType.movie }
            completion(isSuccess, movies)
        }
    }
}
