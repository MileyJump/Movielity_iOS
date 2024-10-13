//
//  SearchResultsViewModel.swift
//  Movielity
//
//  Created by 이윤지 on 10/12/24.
//

import Foundation

import RxSwift
import RxCocoa

class SearchResultsViewModel: ViewModelType {
    private let disposeBag = DisposeBag()

    struct Input {
        let fetchMoviesTrigger: Observable<String>
    }
    
    struct Output {
        let searchMovies: Driver<[SearchResponse]>
    }
    
    func transform(input: Input) -> Output {
        let searchMovies = input.fetchMoviesTrigger
            .filter { !$0.isEmpty }
            .flatMapLatest { query -> Observable<[SearchResponse]> in
                return SearchNetworkManager.shared.searchMovie(query: query)
                    .map { $0.results }
                    .catchAndReturn([])
            }
            .asDriver(onErrorJustReturn: [])
        
        return Output(searchMovies: searchMovies)
    }
}

