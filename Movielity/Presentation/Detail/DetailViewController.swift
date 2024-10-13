//
//  DetailViewController.swift
//  Movielity
//
//  Created by 강석호 on 10/11/24.
//

import UIKit

import RxSwift
import Kingfisher

final class DetailViewController: BaseViewController<DetailView> {
    deinit {
        print("deinit \(self)")
    }
    
    private let viewModel: DetailViewModel
    private let disposeBag = DisposeBag()
    private let mediaType: MediaType
    private let images = Array(repeating: UIImage(systemName: "star"), count: 12)
    
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
                let imageView = UIImageView()
                imageView.kf.setImage(with: URL(string: imageUrl))
                cell.contentView.addSubview(imageView)
                
                imageView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
            .disposed(by: disposeBag)
    }
}
