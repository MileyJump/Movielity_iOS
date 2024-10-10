//
//  HomeCollectionViewCell.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit
import SnapKit
import Then

final class HomeCollectionViewCell: BaseCollectionViewCell {
    
    private let posterImageView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.image = UIImage(systemName: "star")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.layer.cornerRadius = 5
    }
    
    override func setupSubviews() {
        addSubview(posterImageView)
    }
    
    override func setupLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

