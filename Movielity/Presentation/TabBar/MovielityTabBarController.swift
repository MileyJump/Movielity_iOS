//
//  MovielityTabBarController.swift
//  Movielity
//
//  Created by 최민경 on 10/10/24.
//

import UIKit

final class MovielityTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabs: [MovielityTabBar] = [.mainHome, .search, .download]
        
        var viewControllers: [UIViewController] = []
        
        for (index, tabBar) in tabs.enumerated() {
            let vc = tabBar.viewController
            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem = UITabBarItem(title: tabBar.title, image: tabBar.image, tag: index)
            viewControllers.append(nav)
        }
        
        setViewControllers(viewControllers, animated: true)
        tabBar.tintColor = .gray
    }
}
