//
//  ReviewsTableViewCell.swift
//  Movielity
//
//  Created by 최민경 on 1/30/25.
//

import UIKit

import Then
import SnapKit
import Kingfisher

final class ReviewsTableViewCell: BaseTableViewCell {
    
    private let userImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    private var ratings = [UIImageView]()
    
    private let ratingStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .fillEqually
    }
    
    private let ratingLabel = UILabel().then {
        $0.textColor = CustomAppColors.white.color
        $0.font = .boldSystemFont(ofSize: 13)
        $0.textAlignment = .left
        
    }
    
    private let reviewsLabel = UILabel().then {
        $0.textColor = CustomAppColors.white.color
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    private let userNameLabel = UILabel().then {
        $0.textColor = CustomAppColors.white.color
        $0.font = .systemFont(ofSize: 11)
        $0.numberOfLines = 1
    }
    
    private let dateLabel = UILabel().then {
        $0.textColor = CustomAppColors.white.color
        $0.font = .systemFont(ofSize: 11)
        $0.numberOfLines = 1
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setupUI() {
        backgroundColor = CustomAppColors.backgroundBlack.color
    }
    
    override func setupSubviews() {
        addSubview(userImageView)
        addSubview(ratingStackView)
        addSubview(ratingLabel)
        addSubview(reviewsLabel)
        addSubview(userNameLabel)
        addSubview(dateLabel)
        
        for _ in 0..<5 {
            let ratingImageView = UIImageView()
            ratingImageView.contentMode = .scaleAspectFit
            ratings.append(ratingImageView)
            ratingStackView.addArrangedSubview(ratingImageView)
        }
    }
    
    override func setupLayout() {
        userImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(5)
            make.size.equalTo(50)
        }
        
        ratingStackView.snp.makeConstraints { make in
            make.top.equalTo(userImageView)
            make.leading.equalTo(userImageView.snp.trailing).offset(5)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        ratingLabel.snp.makeConstraints { make in
//            make.top.equalTo(userImageView.snp.top)
            make.leading.equalTo(ratingStackView.snp.trailing).offset(5)
            make.centerY.equalTo(ratingStackView)
        }
        
        reviewsLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingStackView.snp.bottom).offset(5)
            make.leading.equalTo(ratingStackView.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(5)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewsLabel.snp.bottom).offset(10)
            make.leading.equalTo(reviewsLabel.snp.leading)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.top)
            make.leading.equalTo(userNameLabel.snp.trailing).offset(4)
            make.bottom.equalTo(userNameLabel)
        }
        
        
    }
    
    func configure(_ review: Review) {
        ratingLabel.text = "\(review.author_details.rating ?? 0)"
        reviewsLabel.text = review.content
        userNameLabel.text = review.author_details.name
        dateLabel.text = dateFormatter(review.created_at)

        
        let rating = review.author_details.rating ?? 0
        let fullStars = Int(rating / 2)
        let halfStars = (rating.truncatingRemainder(dividingBy: 2)) > 0 ? 1 : 0
        
        // 별 이미지 설정
        for (index, imageView) in ratings.enumerated() {
            if index < fullStars {
                imageView.image = UIImage(systemName: "star.fill")
            } else if index < fullStars + halfStars {
                imageView.image = UIImage(systemName: "star.leadinghalf.filled")
            } else {
                imageView.image = UIImage(systemName: "star")
            }
        }
        
        if let profileImage = review.author_details.avatar_path {
            let imageURL = URL(string: "\(APIUrl.photoBaseURL)" + profileImage)
            userImageView.kf.setImage(with: imageURL)
        } else {
            userImageView.image = UIImage(systemName: "person.circle.fill")
        }
    }
    
    func dateFormatter(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy.MM.dd. HH:mm"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    
}
