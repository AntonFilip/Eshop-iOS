//
//  SingleMovieViewModel.swift
//  Movies
//
//  Created by Duje Medak on 07/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation

protocol SingleMovieViewModelType {
    var movie: MovieModel {get}
    weak var viewDelegate: MovieDetailsDelegate? {get set}
}

protocol EditMoviePlotDelegate:NSObjectProtocol{
    func saveEdited(plot: String)
}

class SingleMovieViewModel:NSObject, SingleMovieViewModelType{
    var movie: MovieModel
    let restAPI: RestAPI
    
    weak var viewDelegate: MovieDetailsDelegate?
    
    init(service: RestAPI, movie: MovieModel) {
        self.restAPI = service
        self.movie = movie
    }
    
    var title: String {
        return movie.name.uppercased()
    }
    
    var year: String {
        return movie.price
    }
    
    var plot: String{
        if let plot = movie.plot{
            return plot + "\n"
        }
        return "Plot is not available for this movie...\n"
    }
    
    var genre: String {
        if let genre = movie.genre{
            return genre
        }
        return "Unknown"
    }
    
    var director: String? {
        if let director = movie.director{
            return director
        }
        return "Unknown"
    }
    
    var imageUrl: URL? {
        return URL(string: movie.thumbnail)
    }
    
    func fetchMovieDetails(){
        restAPI.fetchMovieModel(movieID: movie.id, completion:{ [weak self] (movie) in
            if let newMovie = movie{
                self?.movie = newMovie
                self?.viewDelegate?.searchResultsDidChanged()
            }
        })
    }
}

extension SingleMovieViewModel:EditMoviePlotDelegate{
    func saveEdited(plot: String){
        if let updatedMovie = MovieModel.updatePlot(movieID: movie.id, newPlot: plot){
            self.movie = updatedMovie
            viewDelegate?.moviePlotChanged()
        }
    }
}

