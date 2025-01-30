//
//  Reviews.swift
//  Movielity
//
//  Created by 최민경 on 1/30/25.
//

import Foundation

import Foundation

struct ReviewResponse: Decodable {
    let id: Int
    let page: Int
    let results: [Review]
    let total_pages: Int
    let total_results: Int
}

struct Review: Decodable {
    let author: String
    let author_details: AuthorDetails
    let content: String
    let created_at: String
    let id: String
    let updated_at: String
    let url: String
}

struct AuthorDetails: Decodable {
    let name: String?
    let username: String?
    let avatar_path: String?
    let rating: Double?
}
