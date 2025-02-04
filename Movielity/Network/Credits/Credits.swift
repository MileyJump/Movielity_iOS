//
//  Credits.swift
//  Movielity
//
//  Created by 강석호 on 10/11/24.
//

import Foundation

import Alamofire

struct Credits: Decodable {
    let cast: [CreditsResponse]
}

struct CreditsResponse: Decodable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let known_for_department: String?
    let name: String?
    let original_name: String?
    let popularity: Double?
    let profile_path: String?
    let character: String?
    let credit_id: String?
    let order: Int
}
