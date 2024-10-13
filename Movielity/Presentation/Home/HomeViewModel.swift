//
//  HomeViewModel.swift
//  Movielity
//
//  Created by 최민경 on 10/11/24.
//

import Foundation

import RxSwift
import RxCocoa

final class HomeViewModel {
    private let disposeBag = DisposeBag()
    
    let fetchTrendingMovies = PublishSubject<Void>()
    let fetchTrendingSeries = PublishSubject<Void>()
    
    // Output
    let trendingMovies = PublishSubject<[TrendingMovieResponse]>()
    let trendingSeries = PublishSubject<[TrendingSeriesResponse]>()
    
    
    // 랜덤 포스터 이미지를 방출할 Observable
    let randomPosterImageURL = PublishSubject<String?>()
    let genreText = PublishSubject<String>()
    
    init() {
        setupBinding()
    }
    
    private func setupBinding() {
        
        // 영화 데이터를 불러오는 로직
        fetchTrendingMovies
            .flatMap { TrendingNetworkManager.shared.trendingMovies() }
            .map { $0.results } // API에서 받아온 결과 중 영화 리스트만 추출
            .bind(with: self, onNext: { owner, movies in
                owner.trendingMovies.onNext(movies)
            })
            .disposed(by: disposeBag)
        
        // 시리즈 데이터를 불러오는 로직
        fetchTrendingSeries
            .flatMap { TrendingNetworkManager.shared.trendingSeries() }
            .map { $0.results }
            .bind(with: self, onNext: { owner, series in
                owner.trendingSeries.onNext(series)
            })
            .disposed(by: disposeBag)
        
        // 영화와 시리즈 데이터를 결합하고 랜덤 포스터 이미지를 선택
        Observable.combineLatest(trendingMovies, trendingSeries)
            .map { movies, series in
                let moviePosters = movies.compactMap { $0.poster_path }
                let seriesPosters = series.compactMap { $0.poster_path }
                let allPosters = moviePosters + seriesPosters
                let randomPoster = allPosters.randomElement()
                if let randomPoster {
                    // 영화 혹은 시리즈에서 해당 포스터에 맞는 작품 찾기
                    if let movie = movies.first(where: { $0.poster_path == randomPoster }) {
                        // 영화 장르 불러오기
                        if let id = movie.genre_ids {
                            print("영화 장르 ID : \(id)")
                            self.fetchGenre(forMovieId: id)
                        }
                    } else if let series = series.first(where: { $0.poster_path == randomPoster }) {
                        // 시리즈 장르 불러오기
                        if let id = series.genre_ids {
                            print("시리즈 장르 ID: \(id)")
                            self.fetchGenre(forSeriesId: id)
                        }
                    }
                }
                return randomPoster
            }
            .bind(to: randomPosterImageURL)
            .disposed(by: disposeBag)
    }
    
    // 영화의 장르를 불러오는 함수
    private func fetchGenre(forMovieId ids: [Int]) {
        GenreNetworkManager.shared.genreMovies()
            .map { genreResponse in
                // 주어진 ID들에 해당하는 장르 이름들을 필터링
                let genreNames = genreResponse.genres
                    .filter { ids.contains($0.id) } // 주어진 IDs에 해당하는 장르만 필터링
                    .map { $0.name }
                return genreNames.isEmpty ? "Unknown" : genreNames.joined(separator: " · ") // 장르 이름들을 " · "로 구분하여 결합
            }
            .bind(to: genreText)
            .disposed(by: disposeBag)
    }
    
    // 시리즈의 장르를 불러오는 함수
    private func fetchGenre(forSeriesId ids: [Int]) {
        GenreNetworkManager.shared.genreSeries()
            .map { genreResponse in
                let genreNames = genreResponse.genres
                    .filter { ids.contains($0.id) } // 주어진 IDs에 해당하는 장르만 필터링
                    .map { $0.name }
                print("===")
                print(genreNames)
                return genreNames.isEmpty ? "Unknown" : genreNames.joined(separator: " · ") // 장르 이름들을 " · "로 구분하여 결합
            }
            .bind(to: genreText)
            .disposed(by: disposeBag)
    }
}
