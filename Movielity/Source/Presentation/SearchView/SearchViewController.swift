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

   
    private var movies: [DummyTrendingMovieResponse] = [
        DummyTrendingMovieResponse(
            backdrop_path: nil,
            id: 1,
            title: "샘플 영화 1",
            original_title: "샘플 영화 1",
            overview: "이것은 첫 번째 샘플 영화입니다.",
            poster_path: nil,
            media_type: "movie",
            adult: false,
            original_language: "ko",
            genre_ids: [18],
            popularity: 8.1,
            release_date: "2024-10-01",
            vote_average: 7.5,
            vote_count: 120
        ),
        DummyTrendingMovieResponse(
            backdrop_path: nil,
            id: 2,
            title: "샘플 영화 2",
            original_title: "샘플 영화 2",
            overview: "이것은 두 번째 샘플 영화입니다.",
            poster_path: nil,
            media_type: "movie",
            adult: false,
            original_language: "ko",
            genre_ids: [28, 12],
            popularity: 7.3,
            release_date: "2024-10-02",
            vote_average: 6.8,
            vote_count: 85
        ),
        DummyTrendingMovieResponse(
            backdrop_path: nil,
            id: 3,
            title: "샘플 영화 3",
            original_title: "샘플 영화 3",
            overview: "이것은 세 번째 샘플 영화입니다.",
            poster_path: nil,
            media_type: "movie",
            adult: false,
            original_language: "ko",
            genre_ids: [16, 35],
            popularity: 6.5,
            release_date: "2024-10-03",
            vote_average: 6.2,
            vote_count: 75
        ),
        DummyTrendingMovieResponse(
            backdrop_path: nil,
            id: 4,
            title: "샘플 영화 4",
            original_title: "샘플 영화 4",
            overview: "이것은 네 번째 샘플 영화입니다.",
            poster_path: nil,
            media_type: "movie",
            adult: false,
            original_language: "ko",
            genre_ids: [14, 53],
            popularity: 9.0,
            release_date: "2024-10-04",
            vote_average: 8.7,
            vote_count: 200
        ),
        DummyTrendingMovieResponse(
            backdrop_path: nil,
            id: 5,
            title: "샘플 영화 5",
            original_title: "샘플 영화 5",
            overview: "이것은 다섯 번째 샘플 영화입니다.",
            poster_path: nil,
            media_type: "movie",
            adult: false,
            original_language: "ko",
            genre_ids: [10749, 18],
            popularity: 8.9,
            release_date: "2024-10-05",
            vote_average: 8.4,
            vote_count: 150
        )
    ]
    
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
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieLikedTableViewCell.identifier, for: indexPath) as? MovieLikedTableViewCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
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
            movies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("영화 선택됨: \(movies[indexPath.row].title ?? "알 수 없음")")
    }
}

// 검색 결과 업데이트 🌟UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let inputSearchText = searchController.searchBar.text, !inputSearchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }

        let filteredMovieTitle = movies.filter { $0.title?.lowercased().contains(inputSearchText.lowercased()) == true }
        
        let resultsVC = searchController.searchResultsController as? SearchResultsViewController
        resultsVC?.DummyMovieTitle = filteredMovieTitle
        resultsVC?.rootView.searchResultsCollectionView.reloadData()
    }
}


