//
//  HomePosterTableViewCell.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit
import Then
import SnapKit

final class HomePosterTableViewCell: BaseTableViewCell {
    
    private let posterImageView = UIImageView().then {
        $0.image = UIImage(systemName: "star")
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 5
    }
    
    let taglabel: UILabel = {
        let label = UILabel()
        label.text = "응원하고픈 · 흥미진진 · 사극 · 전투 · 한국작품"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.setTitle("재생", for: .normal)
        button.setTitleColor(CustomAppColors.backgroundBlack.color, for: .normal)
        button.backgroundColor = CustomAppColors.white.color
        button.tintColor = CustomAppColors.backgroundBlack.color
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let likedListButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitle("내가 찜한 리스트", for: .normal)
        button.backgroundColor = .darkGray
        button.tintColor = CustomAppColors.white.color
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setupSubviews() {
        addSubview(posterImageView)
        addSubview(taglabel)
        addSubview(playButton)
        addSubview(likedListButton)
        
    }
    
    override func setupLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(5)
            
        }
        
        playButton.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.leading).inset(10)
            make.height.equalTo(posterImageView.snp.height).multipliedBy(0.08)
            make.bottom.equalTo(posterImageView.snp.bottom).inset(8)
            make.width.equalTo(posterImageView.snp.width).multipliedBy(0.45)
        }
        
        taglabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(posterImageView).inset(20)
            make.bottom.equalTo(playButton.snp.top).offset(-10)
        }
        
        likedListButton.snp.makeConstraints { make in
            make.trailing.equalTo(posterImageView.snp.trailing).inset(10)
            make.size.equalTo(playButton)
            make.bottom.equalTo(posterImageView.snp.bottom).inset(8)
        }
    }
    
    override func setupUI() {
        backgroundColor = CustomAppColors.backgroundBlack.color
    }
}

