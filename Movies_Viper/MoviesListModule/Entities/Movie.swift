//
//  Movie.swift
//  Movies_Viper
//
//  Created by Mai Hassan on 2/11/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//

import UIKit

class Movie {
    
    var id: String?
    var image = "https://image.tmdb.org/t/p/w185"
    var title: String?
    var overview: String?
    var vote_average: CGFloat?
    let preVideoURL = "https://api.themoviedb.org/3/movie/"
    let postVideoURL = "/videos?api_key=23cca2d1f3e44625a0e74b4f7435b5ea"
    
}

//https://api.themoviedb.org/3/movie/438799/videos?api_key=23cca2d1f3e44625a0e74b4f7435b5ea


//https://www.youtube.com/watch?v=ClnSvRzy-IM
