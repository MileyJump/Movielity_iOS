//
//  ReviewsModel.swift
//  Movielity
//
//  Created by 최민경 on 1/30/25.
//

import Foundation

import RxSwift
import RxCocoa

class ReviewsModel {
    
    struct Output {
        let fetchReviews: Observable<[Review]>
    }
    
    var disposeBag = DisposeBag()
   
    private let movieModel: IntoDetailMovieModel
    
    init(movieModel: IntoDetailMovieModel) {
        self.movieModel = movieModel
    }
    
    func transform() -> Output {
        
        let movieResponse = fetchReviews()
        return Output(fetchReviews: movieResponse )
    }
    
    func fetchReviews() -> Observable<[Review]> {
        if movieModel.media_type == "movie" {
            return ReviewsNetworkManager.shared.reviewsMovies(movie_id: movieModel.id ?? 0)
                .map { review in
                    return review.results
                     
                }
              
        } else if movieModel.media_type == "tv" {
            return ReviewsNetworkManager.shared.reviewsSeries(series_id: movieModel.id ?? 0)
                .map { review in
                    return review.results
                }
        } else {
            return Observable.just([])
        }
    }
}
