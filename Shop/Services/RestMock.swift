//
//  RestMock.swift
//  Movies
//
//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation

class RestMock:RestAPI{
    
    var movies:[MovieModel]?
    
    init() {
        let movie1 = MovieModel()
        movie1.title = "Film 1"
        movie1.id = "1"
        movie1.poster = "http://www.soundset.hr/datastore/imagestore/620_400/620_400_1379001889miso_kovac.jpg"
        movie1.plot = "vrlo zanimljiva radnja"
        movie1.director = "Mate Mišo"
        movie1.genre = "komedija"
        movie1.year = "1984"
        
        let movie2 = MovieModel()
        movie2.title = "Film 2"
        movie2.id = "2"
        movie2.poster = "https://lajoyalink.com/wp-content/uploads/2018/03/Movie.jpg"
        movie2.plot = "još jedna vrlo zanimljiva radnja"
        movie2.director = "Ime Prezime"
        movie2.genre = "akcija"
        movie2.year = "2001"
        
        movies?.append(movie1)
        movies?.append(movie2)
    }
    
    func fetchMovieModel(movieID: String, completion: @escaping ((MovieModel?) -> Void)) -> Void {
        completion(movies?[0])
    }
    
    func fetchMovieModelList(search: String, completion: @escaping (([MovieModel]?) -> Void)){
        completion(movies)
    }
    
}
