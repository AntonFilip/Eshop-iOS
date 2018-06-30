//  Created by Duje Medak on 07/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation

protocol SingleItemViewModelType {
    var item: ItemModel {get}
    weak var viewDelegate: ItemDetailsViewControllerDelegate? {get set}
}

class SingleItemViewModel:NSObject, SingleItemViewModelType{
    var item: ItemModel
    let restAPI: RestAPI
    
    weak var viewDelegate: ItemDetailsViewControllerDelegate?
    
    init(service: RestAPI, item: ItemModel) {
        self.restAPI = service
        self.item = item
    }
    
    var itemName: String {
        return item.name
    }
    
    var itemPrice: String {
        return item.price
    }
    
    var itemDescription: String{
        return item.description
    }

    var imageUrl: URL? {
        return URL(string: item.thumbnail)
    }
    
    func fetchItemDetails(){
        restAPI.fetchItemDetails(itemID: item.id, completion:{ [weak self] (item) in
            if let newItem = item{
                self?.item = newItem
                self?.viewDelegate?.searchResultsDidChanged()
            }
        })
    }
}

