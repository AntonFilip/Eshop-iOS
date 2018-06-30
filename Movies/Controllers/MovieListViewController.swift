//
//  MovieListViewController.swift
//  Movies
//
//  Created by Duje Medak on 06/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

protocol MovieListDelegate:NSObjectProtocol {
    func movieListDidChanged(success:Bool)
    func loadMovieDetails(item: ItemModel)
}

class MovieListViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var tableHeaderView: MoviesTableHeaderView!
    var spinnerView: UIView?
    var viewModel: MoviesViewModel!
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    convenience init(viewModel: MoviesViewModel) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.viewDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupData()
    }
    
    func setupTableView() {
        tableHeaderView = MoviesTableHeaderView()
        tableHeaderView.setTitle(title: "Searching movies...")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func setupData() {
        spinnerView = MovieListViewController.displaySpinner(onView: self.tableView)
        viewModel.fetchMovies()
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

extension MovieListViewController: UITableViewDelegate {
    
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

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MovieTableViewCell
        
        if let movie = viewModel.getMovie(at: indexPath.row) {
            cell.setup(withMovie: movie)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }
}

extension MovieListViewController: MovieListDelegate{
    
    func movieListDidChanged(success:Bool) {
        if let sv = spinnerView {
            MovieListViewController.removeSpinner(spinner: sv)
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
    
    func loadMovieDetails(item: ItemModel) {
        let smvm = SingleMovieViewModel(service: CombinedMovieAPI(),item:item)
        let vc = MovieDetailsViewController(viewModel: smvm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieListViewController {
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

