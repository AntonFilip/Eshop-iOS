//  Created by Duje Medak on 06/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import CoreData
import AERecord


protocol ItemListViewModelType {
    var items: [ItemModel]? {get}
    weak var viewDelegate: ItemListViewControllerDelegate? {get set }
}

class ItemListViewModel: ItemListViewModelType {
    let restAPI: RestAPI
    let search: String
    
    weak var viewDelegate: ItemListViewControllerDelegate?
    
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
    
    init(service: RestAPI, title:String) {
        self.restAPI = service
        self.search = title
    }
    
    func fetchItems(){
        restAPI.fetchItemList(search:self.search, completion:{ [weak self] (items) in
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

