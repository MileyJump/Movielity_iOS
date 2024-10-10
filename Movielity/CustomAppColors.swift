//
//  CustomAppColors.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit

enum CustomAppColors {
    case white
    case backgroundBlack
    case darkGray1B1B1E
    case redFC2125
    
    var color: UIColor {
        switch self {
        case .white:
            return UIColor.white
        case .backgroundBlack:
            return UIColor.black
        case .darkGray1B1B1E:
            return UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1.00) //#1B1B1E
        case .redFC2125:
            return UIColor(red: 0.99, green: 0.13, blue: 0.15, alpha: 1.00) //#FC2125

        }
    }
}


