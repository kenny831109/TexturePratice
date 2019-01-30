//
//  TabBarController.swift
//  TexturePratice
//
//  Created by 逸唐陳 on 2019/1/30.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        let bagVC = UINavigationController(rootViewController: LoginViewController())
        bagVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "bag"), selectedImage: nil)
        bagVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let mapVC = UINavigationController(rootViewController: MapViewController())
        mapVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "map"), selectedImage: nil)
        mapVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let marketVC = UINavigationController(rootViewController: MarketViewController())
        marketVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "market"), selectedImage: nil)
        marketVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let tagVC = UINavigationController(rootViewController: TagViewController())
        tagVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tag"), selectedImage: nil)
        tagVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let friendVC = UINavigationController(rootViewController: FriendViewController())
        friendVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "friend"), selectedImage: nil)
        friendVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        viewControllers = [bagVC,mapVC,marketVC,tagVC,friendVC]
        self.selectedIndex = 2
    }
    
}
