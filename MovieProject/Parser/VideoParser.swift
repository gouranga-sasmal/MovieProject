//
//  ExerciseParser.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import Foundation

/// Parser
protocol Parseable {
    func parse<T: Codable>(_ data: Data) -> T?
}

extension Parseable {
    func parse<T: Codable>(_ data: Data) -> T? {
        let model = try? JSONDecoder().decode(T.self, from: data)
        return model
    }
}

struct VideoParser: Parseable {
    // if you want to give any custom implementation
    /*
    func parse<T: Codable>(_ data: Data) -> T? {
        // custom implementation goes here
    }*/
}
