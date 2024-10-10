//
//  HomeTableViewCell.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit
import SnapKit
import Then

final class HomeTableViewCell: BaseTableViewCell {
    
    private let nowHotLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18)
        $0.text = "지금 뜨는 영화"
        $0.textColor = CustomAppColors.white.color
    }
    
     let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.posterCollectionViewLayout())
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        collectionView.isPagingEnabled = true
    }
    
    override func setupSubviews() {
        addSubview(nowHotLabel)
        addSubview(collectionView)
        
        

    }
    
    override func setupLayout() {
        nowHotLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(nowHotLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    override func setupUI() {
        backgroundColor = CustomAppColors.backgroundBlack.color
        collectionView.backgroundColor = CustomAppColors.backgroundBlack.color
        
        collectionView.isPagingEnabled = true
    }
}

