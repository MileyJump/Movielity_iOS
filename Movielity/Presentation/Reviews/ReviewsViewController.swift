//
//  ReviewsViewController.swift
//  Movielity
//
//  Created by 최민경 on 1/30/25.
//

import UIKit

import RxSwift


final class ReviewsViewController: BaseViewController<ReviewsView> {
    
    private let viewModel: ReviewsModel
    

    init(movieModel: IntoDetailMovieModel) {
        self.viewModel = ReviewsModel(movieModel: movieModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setupUI() {
        navigationItem.title = "관람평"
        rootView.backgroundColor = CustomAppColors.backgroundBlack.color
    }
    
    private func bind() {
        let output = viewModel.transform()
        
        output.fetchReviews
            .bind(to: rootView.reviewsTableView.rx.items(cellIdentifier: ReviewsTableViewCell.identifier, cellType: ReviewsTableViewCell.self)) { row, review, cell in
                cell.configure(review)
            }
            .disposed(by: disposeBag)
            
            
    }
}
