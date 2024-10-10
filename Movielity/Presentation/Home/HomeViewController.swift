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
        
        rootView.posterTableView.dataSource = self
        rootView.posterTableView.delegate = self
        
        rootView.posterTableView.rowHeight = UITableView.automaticDimension
        rootView.posterTableView.estimatedRowHeight = 450
        
        rootView.posterTableView.register(HomePosterTableViewCell.self, forCellReuseIdentifier: HomePosterTableViewCell.identifier)
        rootView.posterTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
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





extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomePosterTableViewCell.identifier, for: indexPath) as? HomePosterTableViewCell else { return UITableViewCell() }
            
            return cell
        } else {
            // 나머지 셀에서는 HomeTableViewCell 사용
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
            
            cell.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
            
            cell.selectionStyle = .none
            
            cell.collectionView.tag = indexPath.row
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            
            cell.collectionView.isPagingEnabled = true
            
            return cell
        }
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1 {
            return 2
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

