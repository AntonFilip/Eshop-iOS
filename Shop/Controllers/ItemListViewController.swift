//  Created by Duje Medak on 06/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

protocol ItemListViewControllerDelegate:NSObjectProtocol {
    func itemListDidChanged(success:Bool)
    func loadItemDetails(item: ItemModel)
}

class ItemListViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var tableHeaderView: ItemsTableHeaderView!
    var spinnerView: UIView?
    var viewModel: ItemListViewModel!
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    convenience init(viewModel: ItemListViewModel) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.viewDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchItems()
    }
    
    func setupTableView() {
        tableHeaderView = ItemsTableHeaderView()
        tableHeaderView.setTitle(title: "Searching items...")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func fetchItems() {
        spinnerView = ItemListViewController.displaySpinner(onView: self.tableView)
        viewModel.fetchItems()
    }
    
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

extension ItemListViewController: UITableViewDelegate {
    
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

extension ItemListViewController: UITableViewDataSource {
    
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

extension ItemListViewController: ItemListViewControllerDelegate{
    
    func itemListDidChanged(success:Bool) {
        if let sv = spinnerView {
            ItemListViewController.removeSpinner(spinner: sv)
        }
        
        if !success{
            tableHeaderView.setTitle(title: "No results for " + viewModel.search)
            tableView.tableFooterView = UIView()
        }
        else{
            tableView.reloadData()
            animateTable()
            tableHeaderView.setTitle(title: "Results of searching " + viewModel.search)
            tableView.tableFooterView = nil
        }
    }
    
    func loadItemDetails(item: ItemModel) {
        let smvm = SingleItemViewModel(service: CombinedMovieAPI(),item:item)
        let vc = ItemDetailsViewController(viewModel: smvm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ItemListViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            spinnerView.center = onView.convert(onView.center, from:onView.superview)
        }
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

