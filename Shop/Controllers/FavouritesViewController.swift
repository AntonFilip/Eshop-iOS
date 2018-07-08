//
//  FavouritesViewController.swift
//  Shop
//
//  Created by Lovro Buničić on 05/07/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit


protocol FavouritesViewControllerDelegate:NSObjectProtocol {
    func itemListDidChanged(success:Bool)
    func loadItemDetails(item: ItemModel)
}

class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tableHeaderView: ItemsTableHeaderView!

    var viewModel: FavouritesViewModel!
    let cellReuseIdentifier = "cellReuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableHeaderView = ItemsTableHeaderView()
        tableHeaderView.setTitle(title: "Favourites")
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.viewModel.fetchItems()
    }
    
    convenience init(viewModel: FavouritesViewModel) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.viewDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.fetchItems()
        tableView.reloadData()
    }
    
    //MARK:- animation methods
    func animateTable() {
        let cells = tableView.visibleCells
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.25, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}

extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath.row)
    }
}


extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ItemTableViewCell
        
        if let item = viewModel.getItem(at: indexPath.row) {
            cell.setup(with: item)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
}

extension FavouritesViewController: FavouritesViewControllerDelegate{
    
    func itemListDidChanged(success:Bool) {
        
        if !success{
            tableHeaderView.setTitle(title: "No items found.")
            tableView.tableFooterView = UIView()
        }
        else{
            tableView.reloadData()
            animateTable()
            tableHeaderView.setTitle(title: "Favourites")
            tableView.tableFooterView = nil
        }
    }
    
    func loadItemDetails(item: ItemModel) {
        let smvm = SingleItemViewModel(service: CombinedMovieAPI(),item:item)
        let vc = ItemDetailsViewController(viewModel: smvm, shoppingCartVC: ShoppingCartViewController(), showBuy: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
