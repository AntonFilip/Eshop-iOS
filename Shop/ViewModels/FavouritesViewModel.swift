//
//  FavouritesViewModel.swift
//  Shop
//
//  Created by Lovro Buničić on 08/07/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation

protocol FavouritesViewModelType {
    var items: [ItemModel]? {get}
    weak var viewDelegate: FavouritesViewControllerDelegate? {get set }
}

class FavouritesViewModel: FavouritesViewModelType {
    var viewDelegate: FavouritesViewControllerDelegate?
    
    let restAPI: CombinedMovieAPI
    var search: String?
    
    var items : [ItemModel]? = nil {
        didSet{
            if items != nil{
                viewDelegate?.itemListDidChanged(success: true)
            }
            else {
                viewDelegate?.itemListDidChanged(success: false)
            }
        }
    }
    
    init(service: CombinedMovieAPI) {
        self.restAPI = service
    }
    
    func fetchItems(){
        restAPI.fetchFavourites(completion:{ [weak self] (items) in
            self?.items = items
        })
    }
    
    func getItem(at index: Int) -> ItemModel? {
        return items?[index]
    }
    
    func numberOfItems() -> Int {
        return items?.count ?? 0
    }
    
    func didSelectRow(at index: Int) {
        if let item = items?[index]{
            self.viewDelegate?.loadItemDetails(item:item)
        }
    }
}
