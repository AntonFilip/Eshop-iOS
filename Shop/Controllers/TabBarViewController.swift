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
        
        let shoppingCartVM = ShoppingCartViewModel()
        let shoppingCartVC = ShoppingCartViewController(viewModel: shoppingCartVM)
        shoppingCartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "shopping_cart"), tag: 1)
        let shoppingCartNVC = setupNavigationController(vc: shoppingCartVC)
        
        let vm = SearchItemViewModel(service: CombinedMovieAPI())
        let searchVC = SearchItemViewController(viewModel: vm, shoppingCartVC: shoppingCartVC)
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.search, tag: 0)
        let searchNVC = setupNavigationController(vc: searchVC)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "user_male"), tag: 2)
        
        let historyVC = HistoryViewController(viewModel: HistoryViewModel(service: CombinedMovieAPI()))
        historyVC.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(named: "order"), tag: 3)
        let historyNVC = setupNavigationController(vc: historyVC)
        
        let favouritesVM = FavouritesViewModel(service: CombinedMovieAPI())
        let favouritesVC = FavouritesViewController(viewModel: favouritesVM)
        favouritesVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "heart"), tag: 4)
        let favouritesNVC = setupNavigationController(vc: favouritesVC)
        
        let tabBarList = [searchNVC, shoppingCartNVC, profileVC, historyNVC, favouritesNVC]
        
        viewControllers = tabBarList

    }

    func setupNavigationController(vc: UIViewController) -> UINavigationController{
        let nvc = UINavigationController(rootViewController: vc)
        nvc.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        nvc.navigationBar.topItem?.title = "eShop"
        nvc.navigationBar.isTranslucent = false
        nvc.navigationBar.tintColor = .white
        nvc.navigationBar.barTintColor = UIColor(red:0.15, green:0.73, blue:0.60, alpha:1.0)
        return nvc
    }
    
}
