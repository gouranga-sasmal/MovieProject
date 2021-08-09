//
//  VideoListFetchable.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import Foundation

/// Fetch list of video
protocol VideoListFetchable {
    func fetchVideoList(completion: @escaping (_ isSuccess: Bool,_ movies: [VideoModel]) -> Void)
}
