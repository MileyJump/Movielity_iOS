//
//  SearchViewModel.swift
//  Movielity
//
//  Created by 이윤지 on 10/10/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}



class MyViewModel: ViewModelType {
    struct Input {
    }
    
    struct Output {
    }
    
    let disposeBag = DisposeBag()
    
  
    func transform(input: Input) -> Output {
        
        return Output()
    }
}
