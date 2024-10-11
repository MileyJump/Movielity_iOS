//
//  GenreNetworkManager.swift
//  Movielity
//
//  Created by 강석호 on 10/11/24.
//

import Foundation

import Alamofire
import RxSwift

final class GenreNetworkManager {
    static let shared = GenreNetworkManager()
    
    private init() { }
    
    func genreMovies() -> Observable<Genre> {
        return Observable.create { observer in
            do {
                let request = try Router.genreMovie.asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: Genre.self) { response in
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
    
    func genreSeries() -> Observable<Genre> {
        return Observable.create { observer in
            do {
                let request = try Router.genreSeries.asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: Genre.self) { response in
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
