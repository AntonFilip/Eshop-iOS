//
//  TabBarViewController.swift
//  Shop
//
//  Created by Lovro Buničić on 01/07/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vm = SearchItemViewModel(service: CombinedMovieAPI())
        let searchVC = SearchItemViewController(viewModel: vm)
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.search, tag: 0)
        let searchNVC = UINavigationController(rootViewController: searchVC)
        searchNVC.navigationBar.isTranslucent = false
        searchNVC.navigationBar.tintColor = .white
        searchNVC.navigationBar.barTintColor = UIColor(red:0.15, green:0.73, blue:0.60, alpha:1.0)


        let shoppingCartVC = ShoppingCartViewController()
        shoppingCartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "shopping_cart"), tag: 1)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "user_male"), tag: 2)
        
        let tabBarList = [searchNVC, shoppingCartVC, profileVC]
        
        viewControllers = tabBarList

    }

}
