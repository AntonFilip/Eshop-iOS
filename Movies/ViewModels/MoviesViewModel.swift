//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Duje Medak on 06/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import CoreData
import AERecord


protocol MoviesViewModelType {
    var items: [ItemModel]? {get}
    weak var viewDelegate: MovieListDelegate? {get set }
}

class MoviesViewModel: MoviesViewModelType {
    let baseUrl2 = "http://www.omdbapi.com"
    let apiKey2 = "bf90cf2e"
    let restAPI: RestAPI
    let search: String
    
    weak var viewDelegate: MovieListDelegate?
    
    var items : [ItemModel]? = nil {
        didSet{
            if items != nil{
                viewDelegate?.movieListDidChanged(success: true)
            }
            else {
                viewDelegate?.movieListDidChanged(success: false)
            }
        }
    }
    
    init(service: RestAPI, title:String) {
        self.restAPI = service
        self.search = title
    }
    
    func fetchMovies(){
        restAPI.fetchItemList(search:self.search, completion:{ [weak self] (items) in
            self?.items = items
        })
    }
    
    func getMovie(at index: Int) -> ItemModel? {
        return items?[index]
    }
    
    func numberOfMovies() -> Int {
        return items?.count ?? 0
    }
    
    func didSelectRow(at index: Int) {
        if let item = items?[index]{
            self.viewDelegate?.loadMovieDetails(item:item)
        }
    }
}

