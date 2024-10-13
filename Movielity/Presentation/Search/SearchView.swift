//
//  SearchView.swift
//  Movielity
//
//  Created by 이윤지 on 10/9/24.
//

import UIKit

import SnapKit

final class SearchView: BaseView {
    
    let searchTableView = UITableView().then {
        $0.register(MovieLikedTableViewCell.self, forCellReuseIdentifier: MovieLikedTableViewCell.identifier)
        $0.backgroundColor = CustomAppColors.backgroundBlack.color
    }
    
    override func setupSubviews() {
        addSubview(searchTableView)
    }
    
    override func setupLayout() {
        searchTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

