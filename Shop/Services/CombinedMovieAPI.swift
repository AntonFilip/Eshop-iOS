//
//  CombinedMovieAPI.swift
//  Movies
//
//  Created by Duje Medak on 08/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import Reachability

class CombinedMovieAPI:RestAPI{
    
    var connectedToInternet: Bool = false
    let onlineAPI:RestAPI = WalmartAPI()
    let offlineAPI:RestAPI = DataCoreAPI()
    
    func checkForConnection(){
        let reachability = Reachability()!
        
        if reachability.connection == .none {
            connectedToInternet = false
            print("source: stored data")
        }
        else{
            connectedToInternet = true
            print("source: fetching online data")
        }
    }
    
    func fetchItemDetails(itemID: String, completion: @escaping ((ItemModel?) -> Void)) -> Void{
        checkForConnection()
        if connectedToInternet{
            self.onlineAPI.fetchItemDetails(itemID: itemID, completion: completion)
        }
        else{
            self.offlineAPI.fetchItemDetails(itemID: itemID, completion: completion)
        }
    }
    
    func fetchItemList(search: String, completion: @escaping (([ItemModel]?) -> Void)){
        checkForConnection()
        if connectedToInternet{
            self.onlineAPI.fetchItemList(search: search, completion: completion)
        }
        else{
            self.offlineAPI.fetchItemList(search: search, completion: completion)
        }
    }
    
    func fetchFavourites(completion: @escaping (([ItemModel]?) -> Void))  {
        let api = DataCoreAPI()
        api.fetchFavourites(completion: completion)
    }
}

