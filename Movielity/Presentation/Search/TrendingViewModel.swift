//
//  TrendingViewModel.swift
//  Movielity
//
//  Created by 이윤지 on 10/10/24.
//

import Foundation

import RxCocoa

class TrendingViewModel: ViewModelType {
    
    struct Input {
        let fetchMoviesTrigger: Observable<Void>
    }
    
    struct Output {
        let trendingMovies: Driver<[TrendingMovieResponse]>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let trendingMovies = input.fetchMoviesTrigger
            .flatMapLatest { _ -> Observable<[TrendingMovieResponse]> in
                TrendingNetworkManager.shared.trendingMovies()
                    .map { $0.results }
                    .catchAndReturn([])
            }
            .asDriver(onErrorJustReturn: [])
        
        return Output(trendingMovies: trendingMovies)
    }
}



import Foundation
import RxSwift

class SearchResultsViewModel {
    private let disposeBag = DisposeBag()
    
    let searchMoviesSubject = PublishSubject<[SearchResponse]>()
    let searchSeriesSubject = PublishSubject<[SearchResponse]>()
    
    func fetchSearchMovie(query: String) {
        SearchNetworkManager.shared.searchMovie(query: query)
            .map { $0.results }
            .subscribe(onNext: { [weak self] movies in
                self?.searchMoviesSubject.onNext(movies)
            }, onError: { error in
                
            })
            .disposed(by: disposeBag)
    }

    func fetchSearchSeries(query: String) {
        SearchNetworkManager.shared.searchSeries(query: query)
            .map { $0.results }
            .subscribe(onNext: { [weak self] series in
                self?.searchSeriesSubject.onNext(series)
            }, onError: { error in
                
            })
            .disposed(by: disposeBag)
    }
}
