//
//  ItemModel+CoreDataProperties.swift
//  
//
//  Created by Lovro Buničić on 08/07/2018.
//
//

import Foundation
import CoreData


extension ItemModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemModel> {
        return NSFetchRequest<ItemModel>(entityName: "ItemModel")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var price: String
    @NSManaged public var shortItemDescription: String
    @NSManaged public var thumbnail: String
    @NSManaged public var ratingUrl: String
    @NSManaged public var isFavourite: Bool
}
