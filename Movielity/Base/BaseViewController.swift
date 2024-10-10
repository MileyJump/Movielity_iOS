//
//  BaseViewController.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//


import UIKit

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
    
    func setupNavigationBar() {
    }
}


