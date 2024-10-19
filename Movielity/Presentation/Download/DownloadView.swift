//
//  DownloadView.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit
import SnapKit

final class DownloadView: BaseView {
    
    let searchTableView = UITableView().then {
        $0.register(MovieLikedTableViewCell.self, forCellReuseIdentifier: MovieLikedTableViewCell.identifier)
        $0.backgroundColor = CustomAppColors.backgroundBlack.color
    }
    
    override func         setupSubviews() {
        addSubview(searchTableView)
    }
    
    override func setupLayout() {
        searchTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
