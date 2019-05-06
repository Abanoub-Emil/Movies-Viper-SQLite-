//
//  MovieListModuleProtocols.swift
//  Movies_Viper
//
//  Created by Mai Hassan on 2/11/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//
import UIKit

protocol MovieListViewProtocol: class {
    var presenter: MovieListPresenterProtocol? {get set}
    
    func showMovies(movies: [Movie])
    func showError(errorMsg: String)
}


protocol MovieListPresenterProtocol: class {
    var view: MovieListViewProtocol? {get set}
    var interactor: MovieListInteractorProtocol? {get set}
    var router: MovieListRouterProtocol? {get set}

    func getAllMovies()
    func navigateToDetailScreen(movie: Movie, navigationController: UINavigationController)
    func getCachedMovies()
    func showCachedMovies(allMovies: [Movie])
}


protocol MovieListInteractorProtocol: class {
//    var observable: Observable<String> {get}
    var presenter: MovieListPresenterProtocol? {get set}
  
    func getAllMovies(success:@escaping ([Movie]) -> Void, failure:@escaping (Error) -> Void)
    func getCachedMovies()
}

protocol MovieListRouterProtocol: class {
    static func createModule()-> MoviesTableViewController
    func pushToDetailsScreen(movie: Movie, navigationConroller:UINavigationController)
    
}
