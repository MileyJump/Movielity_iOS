//
//  DownloadViewController.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit

import SnapKit
import RealmSwift

final class DownloadViewController: BaseViewController<DownloadView> {
    private var movies: Results<SaveRealmMedia>!
    private let realm = try! Realm()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "검색"
        setupDelegates()
       // fetchMovies()
    }

    private func fetchMovies() {
        movies = realm.objects(SaveRealmMedia.self)
        rootView.searchTableView.reloadData()
    }

    private func setupDelegates() {
        rootView.searchTableView.delegate = self
        rootView.searchTableView.dataSource = self
    }

    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.hidesSearchBarWhenScrolling = false
    }


    private func deleteMovie(at indexPath: IndexPath) {
        let movieToDelete = movies[indexPath.row]
        try! realm.write {
            realm.delete(movieToDelete)
        }
        fetchMovies()  // 삭제 후 테이블 갱신
    }
}


extension DownloadViewController: UITableViewDataSource, UITableViewDelegate {
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
            deleteMovie(at: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("영화 선택됨: \(movies[indexPath.row].title)")
    }
}

