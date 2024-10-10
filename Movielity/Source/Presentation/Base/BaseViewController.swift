//
//  BaseViewController.swift
//  Movielity
//
//  Created by 이윤지 on 10/9/24.
//

import UIKit
import SnapKit

class BaseViewController<RootView: UIView>: UIViewController {
    
    let rootView = RootView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupLayout()
        setupUI()
        setupAddTarget()
        setupNavigationBar()
    }
    
    func setupSubviews() { }
    func setupLayout() { }
    func setupUI() {
        navigationItem.backButtonTitle = ""
        view.backgroundColor = .white
    }
    func setupAddTarget() { }
    func setupNavigationBar() { }
}

