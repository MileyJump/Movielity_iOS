//
//  ReusableProtocol.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension UIView: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}



