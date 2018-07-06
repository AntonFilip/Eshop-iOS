//
//  ShoppingCartViewModel.swift
//  Shop
//
//  Created by Anton Filipović on 06/07/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation

class ShoppingCartViewModel {
    
    var items: [ItemModel]?
    
    func addItem(item: ItemModel){
        items?.append(item)
    }
    
    func getItem(at index: Int) -> ItemModel? {
        return items?[index]
    }
    
    func numberOfItems() -> Int {
        return items?.count ?? 0
    }
}
