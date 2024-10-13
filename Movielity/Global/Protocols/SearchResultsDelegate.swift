//
//  SearchResultsViewControllerDelegate.swift
//  Movielity
//
//  Created by 이윤지 on 10/13/24.
//

import Foundation

protocol SearchResultsDelegate: AnyObject {
    func searchResultsViewControllerDidSelectMovie(_ movie: IntoDetailMovieModel)
}
