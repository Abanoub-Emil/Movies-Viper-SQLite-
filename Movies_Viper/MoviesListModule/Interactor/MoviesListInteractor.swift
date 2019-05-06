//
//  MoviesListInteractor.swift
//  Movies_Viper
//
//  Created by Mai Hassan on 2/11/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieListInteractor: MovieListInteractorProtocol {
    
    weak var presenter: MovieListPresenterProtocol?
    var allMovies = [Movie]()
    let URL = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=23cca2d1f3e44625a0e74b4f7435b5ea"
// UnComment If you are going to use RxSwift
//    var myResult = Variable<String>("")
//    var observable: Observable<String> {
//        return myResult.asObservable()
//}

    func getAllMovies(success: @escaping ([Movie]) -> Void, failure: @escaping (Error) -> Void) {
        AFWrapper.requestGETURL(URL, success: { (json) in
            let movies = JSON(json["results"]).arrayValue
            for movie in movies {
                let myMovie = Movie()
                
                myMovie.id = movie["id"].stringValue
                myMovie.title = movie["title"].stringValue
                myMovie.image += movie["poster_path"].stringValue
                myMovie.overview = movie["overview"].stringValue
                myMovie.vote_average = CGFloat(movie["vote_average"].floatValue)
                
                SQLiteManager.sharedDBManager.insert(movie: myMovie)
                
                print(movie["title"].stringValue)
                self.allMovies.append(myMovie)
            }
            success(self.allMovies)
        }) { (Error) in
            failure(Error)
        }
    }
    
    func getCachedMovies() {
        SQLiteManager.sharedDBManager.createTable()
        let cachedMovies = SQLiteManager.sharedDBManager.getCachedMovies()
        presenter?.showCachedMovies(allMovies: cachedMovies)
    }
    
}
