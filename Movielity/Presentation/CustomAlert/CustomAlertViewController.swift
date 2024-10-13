//
//  CustomAlertViewController.swift
//  Movielity
//
//  Created by 이윤지 on 10/14/24.
//

import UIKit
import SnapKit

class CustomAlertViewController: UIViewController {

    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 12
        return view
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "미디어를 저장했어요 :)"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    private func setupLayout() {
        view.backgroundColor = UIColor.clear

        view.addSubview(alertView)
        alertView.addSubview(messageLabel)
        alertView.addSubview(confirmButton)

        alertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(150)
        }

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(alertView).offset(20)
            make.leading.equalTo(alertView).offset(10)
            make.trailing.equalTo(alertView).offset(-10)
        }

        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(alertView).offset(-20)
            make.leading.equalTo(alertView).offset(20)
            make.trailing.equalTo(alertView).offset(-20)
            make.height.equalTo(44)
        }
    }

    @objc private func confirmButtonTapped() {
            let downloadVC = DownloadViewController()
            navigationController?.pushViewController(downloadVC, animated: true)
        }
}

