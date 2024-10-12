//
//  HomeViewController.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit

import RxSwift
import RxCocoa
import Kingfisher

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
        // 트렌딩 영화 리스트에서 첫 번째 영화를 가져와서 posterImageView에 설정
        viewModel.trendingMovies
            .observe(on: MainScheduler.instance)
            .subscribe(with: self, onNext: { owner, movies in
                let firstMovie = movies.first
                owner.setPosterImage(from: firstMovie?.poster_path)
            })
            .disposed(by: disposeBag)
        
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
    
    private func setPosterImage(from path: String?) {
          guard let path = path else { return }
          let imageUrl = "https://image.tmdb.org/t/p/w500\(path)"
          let url = URL(string: imageUrl)
          rootView.posterImageView.kf.setImage(with: url)
      }
    
    override func setupUI() {
        print("실행 중")
        rootView.backgroundColor = CustomAppColors.backgroundBlack.color
        
        rootView.nowHotMovieCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        rootView.nowHotSeriesCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    }
    
    override func setupNavigationBar() {
        let search = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: nil, action: nil)
        let tv = UIBarButtonItem(image: UIImage(systemName: "sparkles.tv"), style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItems = [search, tv]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        search.rx.tap
            .bind(with: self) { owner, _ in
                owner.searchButtonTapped()
            }
            .disposed(by: disposeBag)

        tv.rx.tap
            .bind(with: self) { owner, _ in
                owner.tvButtonTapped()
            }
            .disposed(by: disposeBag)
    }
    
    private func searchButtonTapped() {
        print("search Button Tapped")
//        let searchVC = SearchViewController()
//        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    private func tvButtonTapped() {
        print("tv Button Tapped")
    }
    
}
