//
//  SimilarNetworkManager.swift
//  Movielity
//
//  Created by 강석호 on 10/11/24.
//

import Foundation

import Alamofire
import RxSwift

final class SimilarNetworkManager {
    static let shared = SimilarNetworkManager()
    
    private init() { }
    
    func similarMovies(movie_id: Int) -> Observable<SimilarMovie> {
        return Observable.create { observer in
            do {
                let request = try Router.similarMovies(movie_id: movie_id).asURLRequest()
                
                AF.request(request)
                    .responseDecodable(of: SimilarMovie.self) { response in
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
