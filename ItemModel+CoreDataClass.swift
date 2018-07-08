//
//  ItemModel+CoreDataClass.swift
//  
//
//  Created by Lovro Buničić on 08/07/2018.
//
//

import Foundation
import CoreData

@objc(ItemModel)
public class ItemModel: NSManagedObject {
    class func createFrom(json: [String: Any]) -> ItemModel? {
        if  let name = json["name"] as? String,
            let price = json["salePrice"] as? Double,
            let thumbnail = json["thumbnailImage"] as? String,
            let itemDescription = json["shortDescription"] as? String,
            let id = json["itemId"] as? Int32{
            
            let item = ItemModel.firstOrCreate(with: ["id": String(id)])
            item.name = name
            item.price = String(price)
            item.thumbnail = thumbnail
            item.shortItemDescription = itemDescription
            item.isFavourite = true
            return item
            
        }
        return nil
    }
    
}
