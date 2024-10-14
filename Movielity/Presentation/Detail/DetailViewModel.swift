//
//  DetailViewModel.swift
//  Movielity
//
//  Created by 강석호 on 10/12/24.
//

import RxSwift
import RxCocoa

final class DetailViewModel {
    struct Output {
        let castNames: Observable<String>
        let similarImages: Observable<[String]>
        let posterImage: Observable<String>
        let title: Observable<String>
        let vote: Observable<String>
        let overview: Observable<String>
        let id: Observable<Int>
        let showSaveAlert: Observable<Bool>
    }
    
    private let movieModel: IntoDetailMovieModel
    
    private let disposeBag = DisposeBag()
    
    private let showSaveAlertSubject = PublishSubject<Bool>()
    
    init(movieModel: IntoDetailMovieModel) {
        self.movieModel = movieModel
    }
    
    func transform() -> Output {
        let castNames = fetchCastNames()
        let similarImages = fetchSimilarImages()
        let posterImage = Observable.just(movieModel.backdrop_path ?? "")
        let title = Observable.just(movieModel.title ?? "")
        let vote = Observable.just("평점: \(movieModel.vote_average ?? 0.0)")
        let overview = Observable.just(movieModel.overview ?? "")
        let id = Observable.just(movieModel.id ?? 0)
        
        return Output(
            castNames: castNames,
            similarImages: similarImages,
            posterImage: posterImage,
            title: title,
            vote: vote,
            overview: overview,
            id: id
            showSaveAlert: showSaveAlertSubject.asObservable()
        )
    }
    
    private func fetchCastNames() -> Observable<String> {
        if movieModel.media_type == "movie" {
            return CreditsNetworkManager.shared.creditsMovies(movie_id: movieModel.id ?? 0)
                .map { credits in
                    let names = credits.cast.compactMap { $0.name }.joined(separator: ", ")
                    return names.isEmpty ? "" : "출연: \(names)"
                }
                .catchAndReturn("")
        } else if movieModel.media_type == "tv" {
            return CreditsNetworkManager.shared.creditsSeries(series_id: movieModel.id ?? 0)
                .map { credits in
                    let names = credits.cast.compactMap { $0.name }.joined(separator: ", ")
                    return names.isEmpty ? "" : "출연: \(names)"
                }
                .catchAndReturn("")
        } else {
            return Observable.just("")
        }
    }
    
    private func fetchSimilarImages() -> Observable<[String]> {
        if movieModel.media_type == "movie" {
            return SimilarNetworkManager.shared.similarMovies(movie_id: movieModel.id ?? 0)
                .map { $0.results.prefix(12).compactMap { $0.poster_path } }
                .catchAndReturn([])
        } else if movieModel.media_type == "tv" {
            return SimilarNetworkManager.shared.similarSeries(series_id: String(movieModel.id ?? 0))
                .map { $0.results.prefix(12).compactMap { $0.poster_path } }
                .catchAndReturn([])
        } else {
            return Observable.just([])
        }
    }
    
    func triggerSaveAlert() {
        showSaveAlertSubject.onNext(true)
    }
}
