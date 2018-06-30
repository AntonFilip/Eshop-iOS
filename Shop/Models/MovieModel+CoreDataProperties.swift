//
//  MovieModel+CoreDataProperties.swift
//  
//
//  Created by Duje Medak on 07/06/2018.
//
//

import Foundation
import CoreData


extension MovieModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieModel> {
        return NSFetchRequest<MovieModel>(entityName: "MovieModel")
    }

    @NSManaged public var title: String
    @NSManaged public var id: String
    @NSManaged public var year: String
    @NSManaged public var poster: String
    @NSManaged public var plot: String?
    @NSManaged public var genre: String?
    @NSManaged public var director: String?

}
