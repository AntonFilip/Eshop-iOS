//
//  SingleMovieViewModel.swift
//  Movies
//
//  Created by Duje Medak on 07/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation

protocol SingleMovieViewModelType {
    var item: ItemModel {get}
    weak var viewDelegate: MovieDetailsDelegate? {get set}
}

protocol EditMoviePlotDelegate:NSObjectProtocol{
    func saveEdited(plot: String)
}

class SingleMovieViewModel:NSObject, SingleMovieViewModelType{
    var item: ItemModel
    let restAPI: RestAPI
    
    weak var viewDelegate: MovieDetailsDelegate?
    
    init(service: RestAPI, item: ItemModel) {
        self.restAPI = service
        self.item = item
    }
    
    var title: String {
        return item.name.uppercased()
    }
    
    var year: String {
        return item.price
    }
    
    var plot: String{
        return "Unknown"
    }
    
    var genre: String {
        return "Unknown"
    }
    
    var director: String? {
        return "Unknown"
    }
    
    var imageUrl: URL? {
        return URL(string: item.thumbnail)
    }
    
    func fetchMovieDetails(){
        restAPI.fetchItemDetails(itemID: item.id, completion:{ [weak self] (item) in
            if let newItem = item{
                self?.item = newItem
                self?.viewDelegate?.searchResultsDidChanged()
            }
        })
    }
}

extension SingleMovieViewModel:EditMoviePlotDelegate{
    func saveEdited(plot: String){
        
    }
}

