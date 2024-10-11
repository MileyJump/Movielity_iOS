//
//  SearchViewController.swift
//  Movielity
//
//  Created by 이윤지 on 10/9/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController<SearchView> {

    let trendingViewModel = TrendingViewModel()
    private var results: [TrendingMovieResponse] = []
    private let disposeBag = DisposeBag()
    
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultsViewController())
        search.searchBar.placeholder = "게임, 시리즈, 영화를 검색하세요..."
        search.searchBar.searchBarStyle = .minimal
        search.searchBar.tintColor = .white
        search.searchBar.searchTextField.textColor = .white
        search.searchBar.barTintColor = .white
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "검색"
        setupDelegates()
        setupNavigationItems()
        
        bindViewModel()
        trendingViewModel.fetchTrendingMovies()
    }

    private func bindViewModel() {
        trendingViewModel.trendingMoviesSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] movies in
                self?.results = movies
                self?.rootView.searchTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func setupDelegates() {
        rootView.searchTableView.delegate = self
        rootView.searchTableView.dataSource = self
        searchController.searchResultsUpdater = self
    }
    
    private func setupNavigationItems() {
        navigationItem.searchController = searchController
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieLikedTableViewCell.identifier, for: indexPath) as? MovieLikedTableViewCell else {
            return UITableViewCell()
        }
        let movie = results[indexPath.row]
        cell.backgroundColor = CustomAppColors.backgroundBlack.color
        cell.configureWithMovie(movie: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // 스와이프 삭제 기능
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            results.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("영화 선택됨: \(results[indexPath.row].title ?? "알 수 없음")")
    }
}

// 검색 결과 업데이트 🌟UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let inputSearchText = searchController.searchBar.text, !inputSearchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let filteredMovieTitle = results.filter { $0.title?.lowercased().contains(inputSearchText.lowercased()) == true }
        
        let resultsVC = searchController.searchResultsController as? SearchResultsViewController
        resultsVC?.DummyMovieTitle = filteredMovieTitle
        resultsVC?.rootView.searchResultsCollectionView.reloadData()
        
        
        
    }
}


