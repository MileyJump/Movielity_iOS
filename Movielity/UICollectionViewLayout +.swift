//
//  UICollectionViewLayout +.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit

extension UICollectionViewLayout {
    
    static func posterCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let numberOfCellsInRow: CGFloat = 4
        let spacing: CGFloat = 5 // 셀 간의 간격
        let totalSpacing = (numberOfCellsInRow * 2) - ( spacing * 3 )
        let width = (UIScreen.main.bounds.width - totalSpacing) / numberOfCellsInRow
        
        layout.itemSize = CGSize(width: width, height: width * 1.3) // 셀 크기 (정사각형으로 설정)
        layout.minimumInteritemSpacing = spacing // 셀 사이 간격
        layout.minimumLineSpacing = spacing // 줄 사이 간격
        layout.sectionInset = UIEdgeInsets(top: 0, left: numberOfCellsInRow, bottom: 0, right: numberOfCellsInRow)
        layout.scrollDirection = .horizontal
        return layout
    }
}

