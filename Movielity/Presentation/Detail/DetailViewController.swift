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
    private let disposeBag = DisposeBag()
    private let mediaType: MediaType
    
    init(viewModel: DetailViewModel, mediaType: MediaType) {
        self.viewModel = viewModel
        self.mediaType = mediaType
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
        let input = DetailViewModel.Input(mediaType: Observable.just(mediaType))
        let output = viewModel.transform(input: input)
        
        output.castNames
            .bind(to: rootView.castLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.similarImages
            .bind(to: rootView.similarCollectionView.rx.items(cellIdentifier: "cell", cellType: UICollectionViewCell.self)) { index, imageUrl, cell in
                let imageView: UIImageView
                if let existingImageView = cell.contentView.subviews.compactMap({ $0 as? UIImageView }).first {
                    imageView = existingImageView
                } else {
                    imageView = UIImageView()
                    imageView.contentMode = .scaleAspectFill
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
    }
}
