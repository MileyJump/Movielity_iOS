//
//  NetworkManager.swift
//  Movielity
//
//  Created by 강석호 on 10/8/24.
//

import Foundation

import Alamofire
import RxSwift

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func searchMovie(query: String) -> Observable<Search> {
        return Observable.create { observer in
            do {
                let request = try Router.searchMovie(query: query).asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: Search.self) { response in
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
    
    func searchSeries(query: String) -> Observable<Search> {
        return Observable.create { observer in
            do {
                let request = try Router.searchSeries(query: query).asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: Search.self) { response in
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
