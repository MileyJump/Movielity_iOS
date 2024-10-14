//
//  MovieLikedTableViewCell.swift
//  Movielity
//
//  Created by 이윤지 on 10/14/24.
//

import UIKit

import SnapKit
import Kingfisher
import Then

final class MovieLikedTableViewCell: UITableViewCell {

    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(systemName: "film")
        $0.backgroundColor = CustomAppColors.darkGray1B1B1E.color
        $0.clipsToBounds = true
    }

    private let titleLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .headline)
        $0.textColor = .white
        $0.text = "샘플 영화 제목"
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }

    private let playButtonCircle = UIImageView().then {
        $0.image = UIImage(systemName: "play.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButtonCircle)
    }

    private func setupLayout() {
        posterImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(100)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(playButtonCircle.snp.leading).offset(-10)
        }

        playButtonCircle.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }

    func configureWithMovie(movie: SaveRealmMedia) {
        titleLabel.text = movie.title
        if !movie.posterImagePath.isEmpty {
            let imageUrl = URL(string: "\(APIUrl.photoBaseURL)" + movie.posterImagePath)
            posterImageView.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "film"))
        } else {
            posterImageView.image = UIImage(systemName: "film")
        }
    }

}

