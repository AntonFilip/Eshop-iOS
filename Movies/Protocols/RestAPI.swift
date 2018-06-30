//
//  RestAPI.swift
//  Movies
//
//  Created by Duje Medak on 14/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation


protocol RestAPI{
    
    func fetchItemDetails(itemID:String, completion: @escaping ((ItemModel?) -> Void)) -> Void
    
    func fetchItemList(search: String, completion: @escaping (([ItemModel]?) -> Void))
}
