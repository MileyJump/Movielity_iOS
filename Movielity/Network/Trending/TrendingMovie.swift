//
//  TrendingMovie.swift
//  Movielity
//
//  Created by 강석호 on 10/10/24.
//

import Foundation

import Alamofire

struct TrendingMovie: Decodable {
    let results: [TrendingMovieResponse]
}

struct TrendingMovieResponse: Decodable {
    let id: Int?
    let title: String?
    let original_title: String?
    let adult: Bool?
    let backdrop_path: String?
    let overview: String?
    let poster_path: String?
    let genre_ids: [Int]?
    let popularity: Double?
    let release_date: String?
    let vote_average: Double?
    let vote_count: Int?
    
    let media_type: String?
    let original_language: String?
}
