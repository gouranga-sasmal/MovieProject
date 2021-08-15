//
//  VideoModel.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import Foundation

// MARK: - WelcomeElement
struct VideoModel: Codable {
    let title, year, rated, released: String?
    let runtime, genre, director, writer: String?
    let actors, plot, language, country: String?
    let awards: String?
    let poster: String?
    let ratings: [Rating]
    let metascore, imdbRating, imdbVotes, imdbID: String?
    let type: VideoType?
    let dvd: String?
    let boxOffice, production: String?
    let website: String?
    let response: String?
    let totalSeasons: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        case totalSeasons
    }
}

// MARK: - Rating
struct Rating: Codable {
    let source: String?
    let value: String?

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

extension Rating {
    
    /// Get unified rating based on total number
    /// - Parameter totalNumber: TOtal number
    /// - Returns: Double value
    func convertedRating(basedOn totalNumber: Double) -> Double? {
        
        // check if value is valid or not
        guard let val = value else { return nil }
              
        // check if rating is in percentage
        if val.hasSuffix("%") {
            // convert percentage to double
            if let fValue = Double(val.replacingOccurrences(of: "%", with: "")) {
                // convert rating to our desired rating
                return (totalNumber * fValue)/100
            } else {
                return nil
            }
        } else {
            // check for divider
            let isDivivderPresent = val.contains("/") //--> 73/100
            
            if isDivivderPresent {
                // split the string in order to get the two value and convert to double
                let values = val.split(separator: "/").map { String($0) }.compactMap { Double($0) }
                // check the count
                guard values.count > 1,
                      let score = values.first,
                      let total = values.last, total > 0 else { return nil }
                // convert rating to our desired rating
                return (score * totalNumber)/total
            } else {
                return nil
            }
        }
    }
}

enum VideoType: String, Codable {
    case movie = "movie"
    case series = "series"
}
