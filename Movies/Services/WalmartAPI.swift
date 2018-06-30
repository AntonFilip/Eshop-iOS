//
//  OmdbAPI.swift
//  Movies
//
//  Created by Duje Medak on 07/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import Alamofire
import AERecord

class WalmartAPI:RestAPI{
    
    //let apiKey = "bf90cf2e"
    //let baseUrl = "http://www.omdbapi.com"
    
    let baseUrl = "http://api.walmartlabs.com/v1/search"
    let apiKey = "24reqa2swxq55ufw8mxs4az5"
    
    func fetchItemDetails(itemID: String, completion: @escaping ((ItemModel?) -> Void)) {
        guard let url = URL(string: baseUrl) else {
            completion(nil)
            return
        }
        // TODO change this call or remove it
        Alamofire.request(url,
                          method: .get,
                          parameters: ["i":itemID,"apikey":apiKey])
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("ERROR:",response)
                    completion(nil)
                    return
                }
                if  let value = response.result.value as? [String: Any],
                    let item = ItemModel.createFrom(json: value){
                    try? AERecord.Context.main.save()
                    completion(item)
                    return
                }
                else {
                    completion(nil)
                    return
                }
        }
    }
    
    func fetchItemList(search: String, completion: @escaping (([ItemModel]?) -> Void)){
        guard let url = URL(string: baseUrl) else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get,
                          parameters: ["query":search, "format":"json", "apikey":apiKey] )
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("ERROR:",response)
                    completion(nil)
                    return
                }
                //print("Response:",response)
                if  let value = response.result.value as? [String: Any],
                    let results = value["items"] as? [[String: Any]] {
                    //print(results)
                    let items = results.map({ json -> ItemModel? in
                        let item = ItemModel.createFrom(json: json)
                        //print("movie:",item)
                        return item
                    }).filter { $0 != nil } .map { $0! }
                    print("movies:",items)
                    try? AERecord.Context.main.save()
                    completion(items)
                    return
                }
                else {
                    completion(nil)
                    return
                }
        }
    }

    
}
