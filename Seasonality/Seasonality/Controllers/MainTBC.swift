//
//  MainTBC.swift
//  Seasonality
//
//  Created by Alex 6.1 on 12/19/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class MainTBC: UITabBarController {
    lazy var produceVC = UINavigationController(rootViewController: ProduceVC())
    lazy var marketVC = UINavigationController(rootViewController: FarmersMarketMap())
    lazy var userVC = UINavigationController(rootViewController: UserVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        produceVC.isNavigationBarHidden = true
        marketVC.isNavigationBarHidden = true
        userVC.isNavigationBarHidden = true

        produceVC.tabBarItem = UITabBarItem(title: "Produce", image: UIImage(systemName: "list.number"), tag: 0)
        marketVC.tabBarItem = UITabBarItem(title: "Markets", image: UIImage(systemName: "magnifyingglass.circle.fill"), tag: 1)
        userVC.tabBarItem = UITabBarItem(title: "User", image: UIImage(systemName: "person.crop.square"), tag: 2)
        
        self.viewControllers = [produceVC,marketVC,userVC]
        self.viewControllers?.forEach({$0.tabBarController?.tabBar.barStyle = .default})
    }
}
