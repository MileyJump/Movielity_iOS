//
//  HomeCollectionViewCell.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Kingfisher

final class HomeCollectionViewCell: BaseCollectionViewCell {
    
    private let posterImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(posterImageView)
    }
    
    override func setupLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with movie: TrendingMovieResponse) {
        if let posterPath = movie.poster_path {
            
            let imageUrl = "https://image.tmdb.org/t/p/w500\(posterPath)"
            let url = URL(string: imageUrl)
            posterImageView.kf.setImage(with: url)
        }
    }
    
    func seriesConfigure(with movie: TrendingSeriesResponse) {
        if let posterPath = movie.poster_path {
            
            let imageUrl = "https://image.tmdb.org/t/p/w500\(posterPath)"
            let url = URL(string: imageUrl)
            posterImageView.kf.setImage(with: url)
                
        }
    }
}

