//
//  DummyMovieDTO.swift
//  Movielity
//
//  Created by 이윤지 on 10/9/24.
//

import Foundation

//struct TrendingMovie: Decodable {
//    let results: [DummyTrendingMovieResponse]
//}

// 영화 정보를 담는 데이터 모델 (더미 데이터를 사용하여 테스트할 때 사용)
struct DummyTrendingMovieResponse: Decodable {
    let backdrop_path: String?
    let id: Int?
    let title: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let media_type: String?
    let adult: Bool?
    let original_language: String?
    let genre_ids: [Int]?
    let popularity: Double?
    let release_date: String?
    let vote_average: Double?
    let vote_count: Int?
   
}


// 탭했을 때 영화 정보를 전달하기 위한 데이터 모델
// 이 구조체는 화면 이동 시 필요한 영화 제목, 이미지, 설명을 담음 (지5워도됨)
//struct MediaDetailViewModel {
//    let movieTitle: String
//    let movieImage: String
//    let movieTitleOverview: String
//}




