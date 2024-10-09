//
//  Router.swift
//  Movielity
//
//  Created by 강석호 on 10/9/24.
//

import Foundation
import Alamofire

enum Router {
    case searchMovie(query: String)
    case searchSeries(query: String)
    case trendingMovies
    case trendingSeries
    case similarMovies(movie_id: String)
    case similarSeries(series_id: String)
    case castMovie(movie_id: String)
    case castSeries(series_id: String)
    case genreMovie
    case genreSeries
}

extension Router: TargetType {
    var baseURL: String {
        return APIUrl.baseURL + "/3"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .searchMovie:
            return "/search/movie"
        case .searchSeries:
            return "/search/tv"
        case .trendingMovies:
            return "/trending/movie/day"
        case .trendingSeries:
            return "/trending/tv/day"
        case .similarMovies(let movie_id):
            return "/movie/\(movie_id)/similar"
        case .similarSeries(let series_id):
            return "/tv/\(series_id)/similar"
        case .castMovie(let movie_id):
            return "/movie/\(movie_id)/credits"
        case .castSeries(let series_id):
            return "/tv/\(series_id)/credits"
        case .genreMovie:
            return "/genre/movie/list"
        case .genreSeries:
            return "/genre/tv/list"
        }
    }
    
    var header: [String: String] {
        return [
            Header.contentType.rawValue: Header.json.rawValue,
            Header.tmdbKey.rawValue: APIKey.tmdbKey
        ]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchMovie(let query):
            return [URLQueryItem(name: "query", value: query)]
        case .searchSeries(let query):
            return [URLQueryItem(name: "query", value: query)]
        default:
            return nil
        }
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
}
