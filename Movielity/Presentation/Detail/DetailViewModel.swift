//
//  DetailViewModel.swift
//  Movielity
//
//  Created by 강석호 on 10/12/24.
//

import RxSwift
import RxCocoa
import RealmSwift

final class DetailViewModel {
    struct Output {
        let castNames: Observable<String>
        let similarImages: Observable<[String]>
        let posterImage: Observable<String>
        let title: Observable<String>
        let vote: Observable<String>
        let overview: Observable<String>
        let showSaveAlert: Observable<String>
    }
    
    private let movieModel: IntoDetailMovieModel
    private let disposeBag = DisposeBag()
    private let realm = try! Realm()

    private let showSaveAlertSubject = PublishSubject<String>()
    
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

        return Output(
            castNames: castNames,
            similarImages: similarImages,
            posterImage: posterImage,
            title: title,
            vote: vote,
            overview: overview,
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
        let existingMedia = realm.object(ofType: SaveRealmMedia.self, forPrimaryKey: movieModel.id)
        
        if existingMedia != nil {
            showSaveAlertSubject.onNext("이미 저장되어 있습니다!")
        } else {
            let newMedia = SaveRealmMedia()
            newMedia.id = movieModel.id ?? 0
            newMedia.title = movieModel.title ?? ""
            newMedia.posterImagePath = movieModel.poster_path ?? ""
            
            try! realm.write {
                realm.add(newMedia)
            }
            showSaveAlertSubject.onNext("미디어를 저장했습니다! :)") 
        }
    }
}
