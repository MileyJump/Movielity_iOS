//
//  MediaDetailViewController.swift
//  Movielity
//
//  Created by 이윤지 on 10/12/24.
//

import UIKit

final class MediaDetailViewController: UIViewController {

    // MediaType: case .movie(let movieID)
    var trendingMovie: TrendingMovieResponse?
    
    var series: TrendingSeriesResponse?


    private let moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupLayout()
        configureView()
    }
    
    // UI 요소 설정
    private func setupSubviews() {
        view.addSubview(moviePosterImageView)
        view.addSubview(movieTitleLabel)
        view.addSubview(overviewLabel)
    }
    
    // 레이아웃 설정 (SnapKit 사용)
    private func setupLayout() {
        moviePosterImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(300)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(moviePosterImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    // 영화 데이터를 UI에 적용
    private func configureView() {
        guard let movie = trendingMovie else { return }
        movieTitleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        if let posterPath = movie.poster_path {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            moviePosterImageView.kf.setImage(with: posterURL)
        }
    }
}

