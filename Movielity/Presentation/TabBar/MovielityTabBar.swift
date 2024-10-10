//
//  MovielityTabBar.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit

enum MovielityTabBar {
    
    case mainHome
    case search
    case download
    
    var viewController: UIViewController {
        switch self {
        case .mainHome:
            return HomeViewController()
        case .search:
            return SearchViewController()
        case .download:
            return DownloadViewController()
        }
    }
    
    var title: String {
        switch self {
        case .mainHome:
            return StringLiterals.Phrase.homeTabBar
        case .search:
            return StringLiterals.Phrase.searchTabBar
        case .download:
            return StringLiterals.Phrase.downloadTabBar
        }
    }
    
    var image: UIImage? {
        switch self {
        case .mainHome:
            return UIImage(systemName: StringLiterals.TabBarIcon.homeTabBar)
        case .search:
            return UIImage(systemName: StringLiterals.TabBarIcon.searchTabBar)
        case .download:
            return UIImage(systemName: StringLiterals.TabBarIcon.downloadTabBar)
        }
    }
    
}
