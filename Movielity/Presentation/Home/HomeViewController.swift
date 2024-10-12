//
//  HomeViewController.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController<HomeView> {
    
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        
        viewModel.fetchTrendingMovies.onNext(())
        viewModel.fetchTrendingSeries.onNext(())
        
    }
    
    private func setupBinding() {
        viewModel.trendingMovies
            .observe(on: MainScheduler.instance)
            .bind(to: rootView.nowHotMovieCollectionView.rx.items(cellIdentifier: HomeCollectionViewCell.identifier, cellType: HomeCollectionViewCell.self)) { row, movie, cell in
                cell.configure(with: movie)
            }
            .disposed(by: disposeBag)
        
        viewModel.trendingSeries
            .observe(on: MainScheduler.instance)
            .bind(to: rootView.nowHotSeriesCollectionView.rx.items(cellIdentifier: HomeCollectionViewCell.identifier, cellType: HomeCollectionViewCell.self)) {
                row, series, cell in
                print(series)
                cell.seriesConfigure(with: series)
            }
            .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        print("실행 중")
        rootView.backgroundColor = CustomAppColors.backgroundBlack.color
        
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

//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == rootView.nowHotMovieCollectionView {
//            return 20
//        } else {
//            return 10
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
//        
//        return cell
//    }
//}

