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
    
    init() {
        setupBinding()
    }
    
    private func setupBinding() {
        
        // 영화 데이터를 불러오는 로직
        fetchTrendingMovies
            .flatMap { TrendingNetworkManager.shared.trendingMovies() }
            .map { $0.results } // API에서 받아온 결과 중 영화 리스트만 추출
            .subscribe(with: self, onNext: { owner, movies in
                owner.trendingMovies.onNext(movies)
            })
            .disposed(by: disposeBag)
        
        // 시리즈 데이터를 불러오는 로직
        fetchTrendingSeries
            .flatMap { TrendingNetworkManager.shared.trendingSeries() }
            .map { $0.results }
            .subscribe(with: self) { owner, series in
                owner.trendingSeries.onNext(series)
            }
            .disposed(by: disposeBag)
        
        // 영화와 시리즈 데이터를 결합하고 랜덤 포스터 이미지를 선택
        Observable.combineLatest(trendingMovies, trendingSeries)
            .map { movies, series in
                let moviePosters = movies.compactMap { $0.poster_path }
                let seriesPosters = series.compactMap { $0.poster_path }
                let allPosters = moviePosters + seriesPosters
                
                return allPosters.randomElement()
            }
            .bind(to: randomPosterImageURL)
            .disposed(by: disposeBag)
    }
    
}
