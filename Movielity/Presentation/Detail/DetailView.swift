//
//  DetailView.swift
//  Movielity
//
//  Created by 강석호 on 10/11/24.
//

import UIKit
import SnapKit

final class DetailView: BaseView {
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let voteAverageLabel = UILabel()
    let playButton = UIButton()
    let saveButton = UIButton()
    let overviewLabel = UILabel()
    let castLabel = UILabel()
    let similarLabel = UILabel()
    
    let similarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override func setupSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(playButton)
        contentView.addSubview(saveButton)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(castLabel)
        contentView.addSubview(similarLabel)
        contentView.addSubview(similarCollectionView)
    }
    
    override func setupUI() {
        scrollView.backgroundColor = .black
        
        posterImageView.image = UIImage(systemName: "star")
        posterImageView.contentMode = .scaleAspectFit
        
        titleLabel.text = "스파이더맨: 홈커밍"
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        voteAverageLabel.text = "8.8"
        voteAverageLabel.textColor = .white
        voteAverageLabel.font = .systemFont(ofSize: 13)
        
        playButton.setTitle("재생", for: .normal)
        playButton.backgroundColor = .blue
        
        saveButton.setTitle("저장", for: .normal)
        saveButton.backgroundColor = .blue
        
        overviewLabel.text = "When you live under the same roof, a family-life bond inevitably develops. That is certainly the case for the inhabitants of Zhan Ke Zhi Jia, a hostel. Xie Ke Zhan, a graduate student who owns the hostel, cares about all of his friends who live there and tries"
        overviewLabel.textColor = .gray
        overviewLabel.numberOfLines = 0
        overviewLabel.font = .boldSystemFont(ofSize: 13)
        
        castLabel.text = "출연: 톰 홀랜드 다우니주니어"
        castLabel.textColor = .gray
        castLabel.font = .systemFont(ofSize: 13)
        
        similarLabel.text = "비슷한 콘텐츠"
        similarLabel.textColor = .white
        similarLabel.font = .boldSystemFont(ofSize: 15)
        
        similarCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }
        
        voteAverageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        playButton.snp.makeConstraints { make in
            make.top.equalTo(voteAverageLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        castLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        similarLabel.snp.makeConstraints { make in
            make.top.equalTo(castLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        similarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(similarLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func updateCollectionViewHeight() {
        similarCollectionView.layoutIfNeeded()
        let contentHeight = similarCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        similarCollectionView.snp.remakeConstraints { make in
            make.top.equalTo(similarLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(contentHeight)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
