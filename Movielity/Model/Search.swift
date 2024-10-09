//
//  Search.swift
//  Movielity
//
//  Created by 강석호 on 10/9/24.
//

import Foundation
import Alamofire

struct Search: Decodable {
    let results: [SearchResponse]
}

struct SearchResponse: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
