//
//  BaseViewController.swift
//  Movielity
//
//  Created by 이윤지 on 10/10/24.
//

import UIKit
import RxSwift

class BaseViewController<RootView: UIView>: UIViewController {
    
    let rootView = RootView()
    
    override func loadView() {
        view = rootView
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureLayout()
        setupUI()
        configureAddTarget()
        configureNavigationBar()
    }
    
    func configureSubviews() { }
    
    func configureLayout() { }
    
    func setupUI() {
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white
    }
    
    func configureAddTarget() { }
    
    func configureNavigationBar() {
    }
}
