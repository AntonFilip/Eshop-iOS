//
//  HistoryViewController.swift
//  Shop
//
//  Created by Lovro Buničić on 05/07/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var purchasesList: UITableView!
    var tableHeaderView: ItemsTableHeaderView!
    var viewModel: HistoryViewModel!
    let cellReuseIdentifier = "historyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPurchasesList()
        viewModel.fetchItems()
    }
    
    convenience init(viewModel: HistoryViewModel){
        self.init()
        self.viewModel = viewModel
    }
    
    func setupPurchasesList() {
        tableHeaderView = ItemsTableHeaderView()
        tableHeaderView.setTitle(title: "Your cart")
        purchasesList.tableFooterView = UIView()
        purchasesList.backgroundColor = UIColor.white
        purchasesList.delegate = self
        purchasesList.dataSource = self
        purchasesList.separatorStyle = .singleLine
        purchasesList.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    

}
extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ItemsTableHeaderView()
        let date = viewModel.getItem(at: section)?.date
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        header.setTitle(title:  "Purchases from " + formatter.string(from: date as! Date) + ": ")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.getItem(at: indexPath.row)
        let smvm = SingleItemViewModel(service: CombinedMovieAPI(), item: item?.relationship?.allObjects[indexPath.row] as! ItemModel)
        let vc = ItemDetailsViewController(viewModel: smvm, shoppingCartVC: ShoppingCartViewController(), showBuy: false)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HistoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ItemTableViewCell
        
        if let item = viewModel.getItem(at: indexPath.section) {
            cell.setup(with: item.relationship?.allObjects[indexPath.row] as! ItemModel)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.getItem(at: section)?.relationship?.count)!
    }
}
