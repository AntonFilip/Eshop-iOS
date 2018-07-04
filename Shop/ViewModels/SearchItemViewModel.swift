//
//  SearchItemViewModel.swift
//  Shop
//
//  Created by Lovro Buničić on 04/07/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import CoreData
import AERecord


protocol ItemListViewModelType {
    var items: [ItemModel]? {get}
    weak var viewDelegate: SearchItemViewControllerDelegate? {get set }
}

class SearchItemViewModel: ItemListViewModelType {
    let restAPI: RestAPI
    var search: String?

    weak var viewDelegate: SearchItemViewControllerDelegate?
    
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
    
    init(service: RestAPI) {
        self.restAPI = service
    }
    
    func fetchItems(for title: String){
        search = title
        restAPI.fetchItemList(search: title, completion:{ [weak self] (items) in
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

