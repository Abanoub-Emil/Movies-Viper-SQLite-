//
//  MoviesListPresenter.swift
//  Movies_Viper
//
//  Created by Mai Hassan on 2/11/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//

import UIKit

class MovieListPresenter: MovieListPresenterProtocol {

    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorProtocol?
    var router: MovieListRouterProtocol?
    
    
    func getAllMovies() {
        interactor?.getAllMovies(success: { [weak self] (movies) in
            self?.view?.showMovies(movies: movies)
        }, failure: { [weak self] (Error) in
            self?.view?.showError(errorMsg: Error.localizedDescription)
        })
    }
    
    func navigateToDetailScreen(movie: Movie, navigationController: UINavigationController){
        router?.pushToDetailsScreen(movie: movie, navigationConroller: navigationController)
    }
    
    func getCachedMovies() {
        interactor?.getCachedMovies()
    }
    
    func showCachedMovies(allMovies: [Movie]){
        if allMovies.count > 1 {
        view?.showMovies(movies: allMovies)
        } else {
            getAllMovies()
        }
    }
}
