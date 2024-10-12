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

//let id: Int?
//let title: String?
//let original_title: String?
//let adult: Bool?
//let backdrop_path: String?
//let overview: String?
//let poster_path: String?
//let genre_ids: [Int]?
//let popularity: Double?
//let release_date: String?
//let vote_average: Double?
//let vote_count: Int?


//id
//title
//original_title
//overview: String?
//poster_path
//vote_average

