//
//  MovieModel+CoreDataClass.swift
//  
//
//  Created by Duje Medak on 07/06/2018.
//
//

import Foundation
import CoreData
import AERecord

@objc(MovieModel)
public class MovieModel: NSManagedObject {
    
    class func createFrom(json: [String: Any]) -> MovieModel? {
        if  let title = json["Title"] as? String,
            let year = json["Year"] as? String,
            let poster = json["Poster"] as? String,
            let id = json["imdbID"] as? String{
            
            //updates existing movie from core data
            if let movie = movieExists(movieID: id){
                // So that it doesn't get overwritten when fetching from internet
                if movie.plot == nil{
                    movie.plot = json["Plot"] as? String
                }
                movie.genre = json["Genre"] as? String
                movie.director = json["Director"] as? String
                return movie
            }
            else{
                let movie = MovieModel.firstOrCreate(with: ["id": id])
                movie.title = title
                movie.id = id
                movie.year = year
                movie.poster = poster
                return movie
            }
            
        }
        return nil
    }
    
    class func updatePlot(movieID:String, newPlot: String) -> MovieModel? {
        if  let movie = movieExists(movieID: movieID){
            movie.plot = newPlot
            try? AERecord.Context.main.save()
            return movie
        }
        return nil
    }
    
    class func movieExists(movieID: String) -> MovieModel? {
        let request: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        let context = AERecord.Context.main
        request.predicate = NSPredicate(format: "id == %@", movieID)
        request.fetchLimit = 1
        if let movie = try? context.fetch(request).first{
            return movie
        }
        return nil
    }
}

