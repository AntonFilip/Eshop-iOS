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

        let shoppingCartVM = ShoppingCartViewModel()
        let shoppingCartVC = ShoppingCartViewController(viewModel: shoppingCartVM)
        shoppingCartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "shopping_cart"), tag: 1)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "user_male"), tag: 2)
        
        let historyVC = HistoryViewController()
        historyVC.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(named: "order"), tag: 3)
        
        let favouritesVM = FavouritesViewModel(service: CombinedMovieAPI())
        let favouritesVC = FavouritesViewController(viewModel: favouritesVM)
        favouritesVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "heart"), tag: 4)
        
        let tabBarList = [searchNVC, shoppingCartVC, profileVC, historyVC, favouritesVC]
        
        viewControllers = tabBarList

    }

}
