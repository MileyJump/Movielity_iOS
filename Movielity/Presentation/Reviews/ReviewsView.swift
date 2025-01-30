//
//  ReviewsView.swift
//  Movielity
//
//  Created by 최민경 on 1/30/25.
//

import UIKit

import Then
import SnapKit

final class ReviewsView: BaseView {
    
    let reviewsTableView = UITableView().then {
        $0.register(ReviewsTableViewCell.self, forCellReuseIdentifier: ReviewsTableViewCell.identifier)
        $0.backgroundColor = CustomAppColors.backgroundBlack.color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(reviewsTableView)
    }
    
    override func setupUI() {
        reviewsTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
