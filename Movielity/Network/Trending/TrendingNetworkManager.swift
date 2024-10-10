//
//  TrendingNetworkManager.swift
//  Movielity
//
//  Created by 강석호 on 10/10/24.
//

import Foundation

import Alamofire
import RxSwift

final class TrendingNetworkManager {
    static let shared = TrendingNetworkManager()
    
    private init() { }
    
    func trendingMovies() -> Observable<TrendingMovie> {
        return Observable.create { observer in
            do {
                let request = try Router.trendingMovies.asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: TrendingMovie.self) { response in
                        switch response.result {
                        case .success(let success):
                            print(success)
                            observer.onNext(success)
                            observer.onCompleted()
                        case .failure(let failure):
                            print(failure)
                            observer.onError(failure)
                        }
                    }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func trendingSeries() -> Observable<TrendingSeries> {
        return Observable.create { observer in
            do {
                let request = try Router.trendingSeries.asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: TrendingSeries.self) { response in
                        switch response.result {
                        case .success(let success):
                            print(success)
                            observer.onNext(success)
                            observer.onCompleted()
                        case .failure(let failure):
                            print(failure)
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
