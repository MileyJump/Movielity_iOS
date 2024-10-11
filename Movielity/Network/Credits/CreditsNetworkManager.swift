//
//  CreditsNetworkManager.swift
//  Movielity
//
//  Created by 강석호 on 10/11/24.
//

import Foundation

import Alamofire
import RxSwift

final class CreditsNetworkManager {
    static let shared = CreditsNetworkManager()
    
    private init() { }
    
    func creditsMovies(movie_id: Int) -> Observable<Credits> {
        return Observable.create { observer in
            do {
                let request = try Router.creditsMovie(movie_id: movie_id).asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: Credits.self) { response in
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
    
    func creditsSeries(series_id: Int) -> Observable<Credits> {
        return Observable.create { observer in
            do {
                let request = try Router.creditsSeries(series_id: series_id).asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: Credits.self) { response in
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
