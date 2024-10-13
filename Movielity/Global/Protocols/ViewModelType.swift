//
//  ViewModelType.swift
//  Movielity
//
//  Created by 이윤지 on 10/13/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
