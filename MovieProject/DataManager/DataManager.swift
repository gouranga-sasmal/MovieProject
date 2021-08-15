//
//  DataManager.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import Foundation

struct DataManager: MovieListFetchable {
    
    let fileName: String
    
    func fetchVideoList(completion: @escaping (Bool, [VideoModel]) -> Void) {
        
        // Here I used Dependency Inversion
        // Since, we are fetching data from file. Thats why I took FileDataProvider
        // Now, if you want to fetch the data from server, then create class/struct and confirm to Fetchable protocol. And use that class(like NetworkDataProvider) here. Thats all you need to change.
        let fetcher: Fetchable = FileDataProvider(fileName: fileName)
        
        // initiate parser
        let parser: Parseable = VideoParser()
        
        self.fetchVideos(from: fetcher, parseUsing: parser, completion: completion)
        
        /*fetcher.fetchData { (data, error) in
            // check for error
            guard let dt = data else {
                completion(false, [])
                return
            }
            
            // initiate parser and parse
            let parser: Parseable = VideoParser()
            guard let videoList: [VideoModel] = parser.parse(dt) else {
                completion(false, [])
                return
            }
            
            completion(true, videoList)
        }*/
    }
    
    func fetchVideos<T: Codable>(from fetcher: Fetchable, parseUsing parser: Parseable,completion: @escaping (Bool, [T]) -> Void) {
        fetcher.fetchData { (data, error) in
            // check for error
            guard let dt = data else {
                completion(false, [])
                return
            }
            
            // parse
            guard let list: [T] = parser.parse(dt) else {
                completion(false, [])
                return
            }
            
            completion(true, list)
        }
    }
}
