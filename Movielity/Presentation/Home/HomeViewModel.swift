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
    
    init() {
        setupBinding()
    }
    
    private func setupBinding() {
        fetchTrendingMovies
            .flatMap { TrendingNetworkManager.shared.trendingMovies() }
            .map { $0.results } // API에서 받아온 결과 중 영화 리스트만 추출
            .subscribe(with: self, onNext: { owner, movies in
                owner.trendingMovies.onNext(movies)
            })
            .disposed(by: disposeBag)
    }
}
