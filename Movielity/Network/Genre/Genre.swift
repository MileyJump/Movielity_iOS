//
//  Genre.swift
//  Movielity
//
//  Created by 강석호 on 10/11/24.
//

import Foundation

import Alamofire

struct Genre: Decodable {
    let genres: [GenreResponse]
}

struct GenreResponse: Decodable {
    let id: Int
    let name: String
}
