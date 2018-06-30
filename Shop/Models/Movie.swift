//
//  Movie.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation

class Movie{
    var title: String
    var imageURI : String
    var description: String
    var year: Int
    var director:Person
    var genre:Genre
    
    
    init(title: String, uri:String, description: String, year: Int , genre: Genre, author:Person) {
        self.title = title
        self.imageURI = uri
        self.description = description
        self.year = year
        self.genre = genre
        self.director = author
    }
    
}

enum Genre:String {
    case comedy = "comedy"
    case action = "action"
    case adventure = "adventure"
    case drama = "Draaama!"
}
