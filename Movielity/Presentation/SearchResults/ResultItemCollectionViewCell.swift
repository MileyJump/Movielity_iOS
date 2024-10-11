//
//  ResultItemCollectionViewCell.swift
//  Movielity
//
//  Created by 이윤지 on 10/9/24.
//

import UIKit
import Then

final class ResultItemCollectionViewCell: BaseCollectionViewCell {
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "film")
        $0.backgroundColor = CustomAppColors.darkGray1B1B1E.color
    }
      
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func configure(with movie: TrendingMovieResponse) {
        posterImageView.image = UIImage(systemName: "film")
    }
}

