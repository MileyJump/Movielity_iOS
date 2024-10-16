//
//  UIView+.swift
//  Movielity
//
//  Created by 강석호 on 10/15/24.
//

import UIKit

extension UIView: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
