//
//  MovielityAlertView.swift
//  Movielity
//
//  Created by 강석호 on 10/14/24.
//

import UIKit
import SnapKit

class MovielityAlertView: BaseView {

    let titleLabel = UILabel()
    let confirmButton = UIButton()

    override func setupSubviews() {
        addSubview(titleLabel)
        addSubview(confirmButton)
    }

    override func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        layer.cornerRadius = 10
        clipsToBounds = true

        titleLabel.text = "미디어를 저장했습니다! :)"
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .center

        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .red
    }

    override func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }

        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(33)
        }
    }
}
