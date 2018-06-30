//
//  ItemModel+CoreDataProperties.swift
//  
//
//  Created by Duje Medak on 30/06/2018.
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
    @NSManaged public var thumbnail: String

}
