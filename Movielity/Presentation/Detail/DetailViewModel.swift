//
//  DetailViewModel.swift
//  Movielity
//
//  Created by 강석호 on 10/12/24.
//

import RxSwift
import RxCocoa

enum MediaType {
    case movie(movieID: Int)
    case series(seriesID: Int)
}

final class DetailViewModel: ViewModelType {
    struct Input {
        let mediaType: Observable<MediaType>
    }
    
    struct Output {
        let castNames: Observable<String>
        let similarImages: Observable<[String]>
    }
    
    func transform(input: Input) -> Output {
        let castNames = input.mediaType
            .flatMap { mediaType -> Observable<Credits> in
                switch mediaType {
                case .movie(let movieID):
                    return CreditsNetworkManager.shared.creditsMovies(movie_id: movieID)
                case .series(let seriesID):
                    return CreditsNetworkManager.shared.creditsSeries(series_id: seriesID)
                }
            }
            .map { credits in
                let names = credits.cast
                    .compactMap { $0.name }.joined(separator: ", ")
                return names.isEmpty ? "" : "출연: \(names)"
            }
            .observe(on: MainScheduler.instance)
        
        let similarImages = input.mediaType
            .flatMap { mediaType -> Observable<[String]> in
                print("aaaaa")
                switch mediaType {
                case .movie(let movieID):
                    return SimilarNetworkManager.shared.similarMovies(movie_id: movieID)
                        .map { similar in
                            return similar.results.prefix(12)
                                .compactMap { $0.poster_path }
                        }
                case .series(let seriesID):
                    return SimilarNetworkManager.shared.similarSeries(series_id: String(seriesID))
                        .map { similar in
                            return similar.results.prefix(12).compactMap { $0.poster_path }
                        }
                }
            }
            .observe(on: MainScheduler.instance)
        
        return Output(castNames: castNames, similarImages: similarImages)
    }
}
