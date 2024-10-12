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

extension TrendingMovieResponse {
    func toIntoMovieModel() -> IntoMovieModel {
        return IntoMovieModel(
            id: self.id,
            title: self.title,
            original_title: self.original_title,
            adult: self.adult,
            backdrop_path: self.backdrop_path,
            overview: self.overview,
            poster_path: self.poster_path,
            genre_ids: self.genre_ids,
            popularity: self.popularity,
            release_date: self.release_date,
            vote_average: self.vote_average,
            vote_count: self.vote_count,
            video: nil,
            media_type: self.media_type,
            original_language: self.original_language
        )
    }
}
