//
//  DownloadViewController.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//


import UIKit
import SnapKit

// 영화 정보를 담는 데이터 모델 (더미 데이터를 사용하여 테스트할 때 사용)
struct DummyMovie: Decodable {
    let id: Int?
    let backdrop_path: String?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let name: String?
    let original_name: String?
}

import UIKit

final class DownloadViewController: BaseViewController<DownloadView> {
   
    // 영화에 대한 샘플 데이터
    private var movies: [DummyMovie] = [
        DummyMovie(id: 1, backdrop_path: nil, original_title: "샘플 영화 1", overview: "이것은 첫 번째 샘플 영화입니다.", popularity: 8.1, poster_path: nil, release_date: "2024-10-01", title: "샘플 영화 1", name: nil, original_name: nil),
        DummyMovie(id: 2, backdrop_path: nil, original_title: "샘플 영화 2", overview: "이것은 두 번째 샘플 영화입니다.", popularity: 7.3, poster_path: nil, release_date: "2024-10-02", title: "샘플 영화 2", name: nil, original_name: nil),
        DummyMovie(id: 3, backdrop_path: nil, original_title: "샘플 영화 3", overview: "이것은 세 번째 샘플 영화입니다.", popularity: 6.5, poster_path: nil, release_date: "2024-10-03", title: "샘플 영화 3", name: nil, original_name: nil),
      
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "검색"
        setupDelegates()
   
    }

    // Delegate 설정 함수
    private func setupDelegates() {
        rootView.searchTableView.delegate = self
        rootView.searchTableView.dataSource = self
       
    }
    
  
    // 네비게이션 바 설정
    override func setupNavigationBar() {
        super.setupNavigationBar()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}


extension DownloadViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieLikedTableViewCell2.identifier, for: indexPath) as? MovieLikedTableViewCell2 else {
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




import UIKit
import SnapKit
import Then

final class MovieLikedTableViewCell2: UITableViewCell {
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "film")
        $0.backgroundColor = CustomAppColors.darkGray1B1B1E.color
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .headline)
        $0.textColor = .white
        $0.text = "샘플 영화 제목"
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    
    private let playButtonCircle = UIImageView().then {
        $0.image = UIImage(systemName: "play.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupLayout()
    }
    
    func setupSubviews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButtonCircle)
    }
    
    private func setupLayout() {
        posterImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(playButtonCircle.snp.leading).offset(-10)
        }
        
        playButtonCircle.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    
    func configureWithMovie(movie: DummyMovie) {
        titleLabel.text = movie.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
