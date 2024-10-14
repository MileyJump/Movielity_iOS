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
        
        // 선택된 탭의 아이콘과 텍스트 색상을 화이트로 설정
        tabBar.tintColor = .white
        
        // 비선택 상태일 때의 아이콘 및 텍스트 색상 설정 (선택 사항)
        tabBar.unselectedItemTintColor = .gray
        
        tabBar.barTintColor = CustomAppColors.darkGray1B1B1E.color
        tabBar.backgroundColor = CustomAppColors.darkGray1B1B1E.color
    }
}
