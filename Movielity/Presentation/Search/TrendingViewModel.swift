//
//  TrendingViewModel.swift
//  Movielity
//
//  Created by 이윤지 on 10/10/24.
//

import Foundation

import RxSwift
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
