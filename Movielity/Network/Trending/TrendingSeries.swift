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
    let id: Int?
    let name: String?
    let original_name: String?
    let adult: Bool?
    let backdrop_path: String?
    let overview: String?
    let poster_path: String?
    let genre_ids: [Int]?
    let popularity: Double?
    let vote_average: Double?
    let vote_count: Int?
    
    let media_type: String?
    let original_language: String?
    let first_air_date: String?
}
