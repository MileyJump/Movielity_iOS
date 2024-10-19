
//
//  HomeView.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit
import Then
import SnapKit

final class HomeView: BaseView {
    
    private let contentScrollView = UIScrollView().then {
        $0.backgroundColor = CustomAppColors.backgroundBlack.color
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = CustomAppColors.backgroundBlack.color
    }
    
    let posterImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let tagLabel = UILabel().then {
        $0.text = "응원하고픈 · 흥미진진 · 사극 · 전투 · 한국작품"
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15)
    }
    
    private let playButton = CustomButton(image: UIImage(systemName: "play.fill"),
                                          title: "재생",
                                          backgroundColor: CustomAppColors.white.color,
                                          tintColor: CustomAppColors.backgroundBlack.color)
    
    
     let likedListButton = CustomButton(image: UIImage(systemName: "plus"),
                                               title: "내가 찜한 리스트",
                                               backgroundColor: CustomAppColors.darkGray1B1B1E.color,
                                               tintColor: CustomAppColors.white.color)
    
    private let nowHotMovieTitle = UILabel().then {
        $0.text = "지금 뜨는 영화"
        $0.textColor = CustomAppColors.white.color
        $0.font = .systemFont(ofSize: 16)
    }
    
    let nowHotMovieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.posterCollectionViewLayout())
    
    private let nowHotSeriesTitle = UILabel().then {
        $0.text = "지금 뜨는 TV 시리즈"
        $0.textColor = CustomAppColors.white.color
        $0.font = .systemFont(ofSize: 16)
    }
    
    let nowHotSeriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.posterCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupUI() {
        nowHotMovieCollectionView.backgroundColor = CustomAppColors.backgroundBlack.color
        nowHotSeriesCollectionView.backgroundColor = CustomAppColors.backgroundBlack.color
        backgroundColor = CustomAppColors.backgroundBlack.color
    }
    
    override func         setupSubviews() {
        
        addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(tagLabel)
        contentView.addSubview(playButton)
        contentView.addSubview(likedListButton)
        contentView.addSubview(nowHotMovieTitle)
        contentView.addSubview(nowHotMovieCollectionView)
        contentView.addSubview(nowHotSeriesTitle)
        contentView.addSubview(nowHotSeriesCollectionView)
    }
    
    override func setupLayout() {
        
        contentScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(contentScrollView)
            make.width.equalTo(contentScrollView.snp.width)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(5)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.4)
        }
        
        playButton.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.leading).inset(10)
            make.height.equalTo(posterImageView.snp.height).multipliedBy(0.08)
            make.bottom.equalTo(posterImageView.snp.bottom).inset(8)
            make.width.equalTo(posterImageView.snp.width).multipliedBy(0.45)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(posterImageView).inset(20)
            make.bottom.equalTo(playButton.snp.top).offset(-10)
        }
        
        likedListButton.snp.makeConstraints { make in
            make.trailing.equalTo(posterImageView.snp.trailing).inset(10)
            make.size.equalTo(playButton)
            make.bottom.equalTo(posterImageView.snp.bottom).inset(8)
        }
        
        nowHotMovieTitle.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
        }
        
        nowHotMovieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(nowHotMovieTitle.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo((UIScreen.main.bounds.width - 10) / 4 * 1.5)
        }
        
        nowHotSeriesTitle.snp.makeConstraints { make in
            make.top.equalTo(nowHotMovieCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(nowHotMovieTitle)
        }
        
        nowHotSeriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(nowHotSeriesTitle.snp.bottom)
            make.height.horizontalEdges.equalTo(nowHotMovieCollectionView)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
