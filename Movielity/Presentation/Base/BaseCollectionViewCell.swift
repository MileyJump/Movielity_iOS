//
//  BaseCollectionViewCell.swift
//  Movielity
//
//  Created by 이윤지 on 10/10/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() { }
    func setupLayout() { }
    func setupUI() { }
}
