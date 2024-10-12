//
//  SearchResultsViewController.swift
//  Movielity
//
//  Created by 이윤지 on 10/9/24.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidSelectMovie(_ movie: IntoMovieModel)
}


final class SearchResultsViewController: BaseViewController<SearchResultsView> {
    
    var movie: [SearchResponse] = []
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        rootView.addSubview(rootView.searchResultsCollectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        rootView.searchResultsCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupDelegates() {
        rootView.searchResultsCollectionView.delegate = self
        rootView.searchResultsCollectionView.dataSource = self
    }
}


extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultItemCollectionViewCell.identifier, for: indexPath) as? ResultItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movieItem = movie[indexPath.row]
        cell.configure(with: movieItem.poster_path ?? "")
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selectedSearchResultMovie = movie[indexPath.row]
        print("선택된 영화: \(selectedSearchResultMovie)")
        
        let movieModel = selectedSearchResultMovie.toIntoMovieModel()
        delegate?.searchResultsViewControllerDidSelectMovie(movieModel)
    }
}


