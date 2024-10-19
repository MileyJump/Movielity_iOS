//
//  SearchResultsView.swift
//  Movielity
//
//  Created by 이윤지 on 10/9/24.
//

import UIKit
import SnapKit

final class SearchResultsView: BaseView {
    
    let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 15, height: 170)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ResultItemCollectionViewCell.self, forCellWithReuseIdentifier: ResultItemCollectionViewCell.identifier)
        collectionView.backgroundColor = CustomAppColors.backgroundBlack.color
        return collectionView
    }()
    
    override func         setupSubviews() {
        addSubview(searchResultsCollectionView)
    }
    
    override func setupLayout() {
        searchResultsCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

