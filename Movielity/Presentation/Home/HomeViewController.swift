//
//  HomeViewController.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit

class HomeViewController: BaseViewController<HomeView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        rootView.backgroundColor = CustomAppColors.backgroundBlack.color
        
        rootView.nowHotMovieCollectionView.dataSource = self
        rootView.nowHotMovieCollectionView.delegate = self
        
        rootView.nowHotSeriesCollectionView.dataSource = self
        rootView.nowHotSeriesCollectionView.delegate = self
        
        rootView.nowHotMovieCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        rootView.nowHotSeriesCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    }
    
    override func setupNavigationBar() {
        let menu = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: nil, action: nil)
        let profile = UIBarButtonItem(image: UIImage(systemName: "sparkles.tv"), style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItems = [menu, profile]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    private func handleMenuButton() {
        // 메뉴 버튼 클릭시 처리할 액션
        print("Menu button clicked")
    }
    
    private func handleProfileButton() {
        // 프로필 버튼 클릭시 처리할 액션
        print("Profile button clicked")
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == rootView.nowHotMovieCollectionView {
            return 20
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

