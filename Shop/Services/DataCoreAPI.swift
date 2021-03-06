//
//  DataCoreAPI.swift
//  Movies
//
//  Created by Duje Medak on 08/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import AERecord
import CoreData

class DataCoreAPI:RestAPI{
    
    func fetchItemDetails(itemID: String, completion: @escaping ((ItemModel?) -> Void)) -> Void{
        let request: NSFetchRequest<ItemModel> = ItemModel.fetchRequest()
        let context = AERecord.Context.main
        request.predicate = NSPredicate(format: "id == %@", itemID)
        
        guard let movie = try? context.fetch(request).first else{
            print("Error while fetching item with id",itemID)
            completion(nil)
            return
        }
        completion(movie)
    }
    
    func fetchItemList(search: String, completion: @escaping (([ItemModel]?) -> Void)){
        let request: NSFetchRequest<ItemModel> = ItemModel.fetchRequest()
        let context = AERecord.Context.main
        request.predicate = NSPredicate(format: "name contains[c] %@", search)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        guard let items = try? context.fetch(request) else{
            print("Error while fetching items with title", search)
            completion(nil)
            return
        }
        
        if items.count > 1 {
            completion(items)
        }
        else{
            completion(nil)
        }
        
    }
    
    func fetchFavourites(completion: @escaping (([ItemModel]?) -> Void))  {
        
        let request: NSFetchRequest<ItemModel> = ItemModel.fetchRequest()
        let context = AERecord.Context.main
        request.predicate = NSPredicate(format: "isFavourite == %@", NSNumber(value: true))
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        guard let items = try? context.fetch(request) else{
            print("Error while fetching favourites items")
            completion(nil)
            return
        }
        
        if items.count > 0 {
            completion(items)
        }
        else{
            completion(nil)
        }
    }
    
    func fetchHistory(completion: @escaping (([Purchase]?) -> Void))  {

        if let history = Purchase.all(){
            completion(history as? [Purchase])
        }
        else{
            completion(nil)
        }
    }
}
