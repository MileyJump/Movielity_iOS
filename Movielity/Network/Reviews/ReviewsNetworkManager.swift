//
//  ReviewsNetworkManager.swift
//  Movielity
//
//  Created by 최민경 on 1/30/25.
//

import Foundation

import Alamofire
import RxSwift

final class ReviewsNetworkManager {
    static let shared = ReviewsNetworkManager()
    
    private init() { }
    
    func reviewsMovies(movie_id: Int) -> Observable<ReviewResponse> {
        return Observable.create { observer in
            do {
                let request = try Router.reviewsMovie(movie_id: movie_id).asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: ReviewResponse.self) { response in
                        switch response.result {
                        case .success(let success):
                            observer.onNext(success)
                            observer.onCompleted()
                        case .failure(let failure):
                            observer.onError(failure)
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    
    func reviewsSeries(series_id: Int) -> Observable<ReviewResponse> {
        return Observable.create { observer in
            do {
                let request = try Router.reviewsSeries(series_id: series_id).asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: ReviewResponse.self) { response in
                        switch response.result {
                        case .success(let success):
                            observer.onNext(success)
                            observer.onCompleted()
                        case .failure(let failure):
                            observer.onError(failure)
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
}
