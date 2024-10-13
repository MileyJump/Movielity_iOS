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
    
    let video: Bool?
}

struct IntoDetailMovieModel: Identifiable {
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
    let video: Bool?
    let media_type: String?
    let original_language: String?
}

extension SearchResponse {
    func toIntoMovieModel() -> IntoDetailMovieModel {
        return IntoDetailMovieModel(
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
            video: self.video,
            media_type: "movie",
            original_language: nil
        )
    }
}
