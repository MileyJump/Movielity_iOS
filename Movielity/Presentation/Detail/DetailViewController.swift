//
//  DetailViewController.swift
//  Movielity
//
//  Created by 강석호 on 10/11/24.
//

import UIKit

import RxSwift
import Kingfisher
import SnapKit

final class DetailViewController: BaseViewController<DetailView> {
    deinit {
        print("deinit \(self)")
    }
    
    private let viewModel: DetailViewModel
    
    init(movieModel: IntoDetailMovieModel) {
        self.viewModel = DetailViewModel(movieModel: movieModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        let output = viewModel.transform()
        
        output.castNames
            .bind(to: rootView.castLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.similarImages
            .bind(to: rootView.similarCollectionView.rx.items(cellIdentifier: "cell", cellType: UICollectionViewCell.self)) { index, imageUrl, cell in
                var imageView: UIImageView
                if let existingImageView = cell.contentView.subviews.compactMap({ $0 as? UIImageView }).first {
                    imageView = existingImageView
                } else {
                    imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFit
                    imageView.clipsToBounds = true
                    cell.contentView.addSubview(imageView)
                    imageView.snp.makeConstraints { make in
                        make.edges.equalToSuperview()
                    }
                }
                
                let fullImageUrl = "https://image.tmdb.org/t/p/w500\(imageUrl)"
                if let url = URL(string: fullImageUrl) {
                    imageView.kf.setImage(with: url)
                }
            }
            .disposed(by: disposeBag)
        
        output.similarImages
            .bind(with: self, onNext: { owner, _ in
                owner.rootView.updateCollectionViewHeight()
            })
            .disposed(by: disposeBag)
        
        output.posterImage
            .compactMap { URL(string: "https://image.tmdb.org/t/p/w500\($0)") }
            .bind(with: self, onNext: { owner, url in
                owner.rootView.posterImageView.kf.setImage(with: url)
            })
            .disposed(by: disposeBag)
        
        output.title
            .bind(to: rootView.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.vote
            .bind(to: rootView.voteAverageLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.overview
            .bind(to: rootView.overviewLabel.rx.text)
            .disposed(by: disposeBag)
        
        rootView.saveButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.viewModel.triggerSaveAlert()
            }
            .disposed(by: disposeBag)
        
        output.showSaveAlert
            .filter { $0 }
            .bind(with: self) { owner, _ in
                owner.showSaveAlertView()
            }
            .disposed(by: disposeBag)
    }
    
    private func showSaveAlertView() {
        let alertView = MovielityAlertView()
        
        view.addSubview(alertView)
        
        alertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
        
        alertView.confirmButton.rx.tap
            .bind(with: self) { owner, _ in
                alertView.removeFromSuperview()
            }
            .disposed(by: disposeBag)
    }
}
