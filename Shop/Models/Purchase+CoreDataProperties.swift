//
//  Purchase+CoreDataProperties.swift
//  
//
//  Created by Lovro Buničić on 08/07/2018.
//
//

import Foundation
import CoreData


extension Purchase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Purchase> {
        return NSFetchRequest<Purchase>(entityName: "Purchase")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension Purchase {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: ItemModel)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: ItemModel)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}
