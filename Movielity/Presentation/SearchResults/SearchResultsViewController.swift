//
//  SearchResultsViewController.swift
//  Movielity
//
//  Created by 이윤지 on 10/9/24.
//

import UIKit
import SnapKit

final class SearchResultsViewController: BaseViewController<SearchResultsView> {
    
    var DummyMovieTitle: [DummyTrendingMovieResponse] = [] // 더미 데이터들
   
    //사진 탭했을 때 미디어상세 화면으로 이동할 때 사용하시면 되는 프로토콜 입니다.
    //weak var delegate: ResultItemViewControllerDelegate?
    
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
        return DummyMovieTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultItemCollectionViewCell.identifier, for: indexPath) as? ResultItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        let title = DummyMovieTitle[indexPath.row]
        cell.configure(with: title)
        return cell
    }
    
    
   // 탭했을 때 영화 정보를 전달 및 화면 이동 (프로토콜을 사용할 예정)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = DummyMovieTitle[indexPath.row]
        
        //        let titlePreviewViewModel = MediaDetailViewModel(
        //            movieTitle: title.title ?? "Unknown",
        //            movieImage: "",
        //            movieTitleOverview: title.overview ?? "No overview available"
        //        )
        //delegate?.ResultItemViewControllerDidTapItem(titlePreviewViewModel)
    }
}


