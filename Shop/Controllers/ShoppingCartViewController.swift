//
//  ShoppingCartViewController.swift
//  Shop
//
//  Created by Lovro Buničić on 01/07/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    @IBOutlet weak var cartList: UITableView!
    var tableHeaderView: ItemsTableHeaderView!
    var viewModel: ShoppingCartViewModel!
    let cellReuseIdentifier = "shoppingCartCell"
    
    convenience init(viewModel: ShoppingCartViewModel){
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCartList()
    }

    func setupCartList() {
        tableHeaderView = ItemsTableHeaderView()
        tableHeaderView.setTitle(title: "Your cart")
        cartList.tableFooterView = UIView()
        cartList.backgroundColor = UIColor.white
        cartList.delegate = self
        cartList.dataSource = self
        cartList.separatorStyle = .singleLine
        cartList.register(UINib(nibName: "ItemcartListCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ShoppingCartViewController: UITableViewDelegate {

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
        let item = viewModel.getItem(at: indexPath.row)
        let smvm = SingleItemViewModel(service: CombinedMovieAPI(), item: item!)
        let vc = ItemDetailsViewController(viewModel: smvm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ShoppingCartViewController: UITableViewDataSource {

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

