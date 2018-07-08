//
//  Purchase+CoreDataClass.swift
//  
//
//  Created by Lovro Buničić on 08/07/2018.
//
//

import Foundation
import CoreData

@objc(Purchase)
public class Purchase: NSManagedObject {
    class func createFrom(items: NSSet) -> Purchase? {
            let purchase = Purchase.firstOrCreate(with: ["date": Date()])
            purchase.relationship = items
            return purchase
    }
}
