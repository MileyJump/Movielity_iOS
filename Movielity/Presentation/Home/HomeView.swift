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
    
    let posterTableView = UITableView().then {
        $0.backgroundColor = CustomAppColors.backgroundBlack.color
    }
    
    let taglabel: UILabel = {
        let label = UILabel()
        label.text = "응원하고픈 · 흥미진진 · 사극 · 전투 · 한국작품"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func setupSubviews() {
        addSubview(posterTableView)
        
    }
    
    override func setupLayout() {
        
        posterTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}

