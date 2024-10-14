//
//  CustomButton.swift
//  Movielity
//
//  Created by 최민경 on 10/12/24.
//
import UIKit

import UIKit

final class CustomButton: UIButton {
    
    init(image: UIImage?, title: String, backgroundColor: UIColor, tintColor: UIColor) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.filled()
        config.image = image
        config.imagePadding = 8
        config.imagePlacement = .leading
        config.baseBackgroundColor = backgroundColor
        config.baseForegroundColor = tintColor
        config.cornerStyle = .medium
    
        if let image = image {
            let resizedImage = image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 13)) // 원하는 크기로 설정
            config.image = resizedImage
        }
        
        var attributedTitle = AttributedString(title)
        attributedTitle.font = UIFont.systemFont(ofSize: 13)
        attributedTitle.foregroundColor = tintColor
        config.attributedTitle = attributedTitle
        
        self.configuration = config
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
