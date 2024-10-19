//
//  BaseView.swift
//  Movielity
//
//  Created by 이윤지 on 10/10/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureLayout()
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() { }
    
    func configureLayout() { }
    
    func configureUI() {
        backgroundColor = .black
    }
}
