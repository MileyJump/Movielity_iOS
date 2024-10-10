//
//  TrendingSeries.swift
//  Movielity
//
//  Created by 강석호 on 10/10/24.
//

import Foundation

import Alamofire

struct TrendingSeries: Decodable {
    let results: [TrendingSeriesResponse]
}

struct TrendingSeriesResponse: Decodable {
    let backdrop_path: String?
    let id: Int?
    let name: String?
    let original_name: String?
    let overview: String?
    let poster_path: String?
    let media_type: String?
    let adult: Bool?
    let original_language: String?
    let genre_ids: [Int]?
    let popularity: Double?
    let first_air_date: String?
    let vote_average: Double?
    let vote_count: Int?
}
