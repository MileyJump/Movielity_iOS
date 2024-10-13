//
//  CustomButton.swift
//  Movielity
//
//  Created by 최민경 on 10/12/24.
//
import UIKit

final class CustomButton: UIButton {
    
    
    init(image: UIImage?, title: String, backgroundColor: UIColor, tintColor: UIColor) {
        super.init(frame: .zero)
        
        setImage(image, for: .normal)
        setTitle(title, for: .normal)
        setTitleColor(tintColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        titleLabel?.font = .systemFont(ofSize: 13)
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


