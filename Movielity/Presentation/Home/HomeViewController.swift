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
        
        // 데이터를 가져오는 트리거
        viewModel.fetchTrendingMovies.onNext(())
        viewModel.fetchTrendingSeries.onNext(())
    }
    
    
    private func setupBinding() {
        
        // 영화 데이터를 컬렉션 뷰에 바인딩
        viewModel.trendingMovies
            .bind(to: rootView.nowHotMovieCollectionView.rx.items(cellIdentifier: HomeCollectionViewCell.identifier, cellType: HomeCollectionViewCell.self)) { row, movie, cell in
                cell.configure(with: movie)
            }
            .disposed(by: disposeBag)
        
        // 시리즈 데이터를 컬렉션 뷰에 바인딩
        viewModel.trendingSeries
            .bind(to: rootView.nowHotSeriesCollectionView.rx.items(cellIdentifier: HomeCollectionViewCell.identifier, cellType: HomeCollectionViewCell.self)) {
                row, series, cell in
                cell.seriesConfigure(with: series)
            }
            .disposed(by: disposeBag)
        
        // 랜덤 포스터 이미지를 구독하여 `posterImageView`에 설정
        viewModel.randomPosterImageURL
            .bind(with: self, onNext: { owner, posterPath in
                owner.setPosterImage(from: posterPath)
            })
            .disposed(by: disposeBag)
    }
    
    private func setPosterImage(from path: String?) {
          guard let path = path else { return }
          let imageUrl = "https://image.tmdb.org/t/p/w500\(path)"
          let url = URL(string: imageUrl)
          rootView.posterImageView.kf.setImage(with: url)
      }
    
    override func setupUI() {
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
    }
    
    private func tvButtonTapped() {
        print("tv Button Tapped")
    }
}
