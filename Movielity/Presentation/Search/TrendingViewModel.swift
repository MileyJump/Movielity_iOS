//
//  TrendingViewModel.swift
//  Movielity
//
//  Created by 이윤지 on 10/10/24.
//

import Foundation
import RxSwift
import RxCocoa

class TrendingViewModel {
    private let disposeBag = DisposeBag()
    
    let trendingMoviesSubject = PublishSubject<[TrendingMovieResponse]>()
    
    func fetchTrendingMovies() {
        TrendingNetworkManager.shared.trendingMovies()
            .map { $0.results }
            .subscribe(onNext: { [weak self] movies in
                self?.trendingMoviesSubject.onNext(movies)
            }, onError: { error in
              //  print("트렌딩무비\(error)")
            })
            .disposed(by: disposeBag)
    }

    func fetchTrendingSeries() {
        TrendingNetworkManager.shared.trendingSeries()
            .subscribe(onNext: { trendingSeries in
             //   print("\(trendingSeries)")
            }, onError: { error in
                //  print("트렌딩시리즈\(error)")
            }, onCompleted: {
              //  print("트렌딩시리즈 완료.")
            })
            .disposed(by: disposeBag)
    }
}



import Foundation
import RxSwift

class SearcViewModel {
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
