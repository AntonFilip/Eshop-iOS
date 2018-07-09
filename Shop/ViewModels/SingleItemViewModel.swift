//  Created by Duje Medak on 07/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import AERecord

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
        return item.shortItemDescription
    }
    
    var imageUrl: URL? {
        return URL(string: item.thumbnail)
    }
    
    var itemId: String {
        return item.id
    }
    
    func toggleIsFavourite() -> Bool{
        print(item.isFavourite)
        item.isFavourite = item.isFavourite ? false : true
        try? AERecord.Context.main.save()
        print(item.isFavourite)
        return item.isFavourite
    }
    
    var ratingUrl: String {
        return item.ratingUrl
    }
    
    func fetchItemDetails(){
        /*
         restAPI.fetchItemDetails(itemID: item.id, completion:{ [weak self] (item) in
         if let newItem = item{
         self?.item = newItem
         self?.viewDelegate?.searchResultsDidChanged()
         }
         })
         */
        
        // itemModel was set while passing from previos view so no need for rest calls since all the data
        // about the item was fetched while filling the item list view...
        viewDelegate?.searchResultsDidChanged()
        
    }
}

