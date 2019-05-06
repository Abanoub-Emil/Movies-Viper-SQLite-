//
//  MoviesListRouter.swift
//  Movies_Viper
//
//  Created by Mai Hassan on 2/11/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//

import UIKit

class MovieListRouter: MovieListRouterProtocol {
    
    static func createModule() -> MoviesTableViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "MoviesTableViewController") as! MoviesTableViewController
        
        let presenter: MovieListPresenterProtocol = MovieListPresenter()
        let interactor: MovieListInteractorProtocol = MovieListInteractor()
        let router: MovieListRouterProtocol = MovieListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    
    func pushToDetailsScreen(movie: Movie, navigationConroller: UINavigationController) {
        let detailModuel = DetailRouter.createModule()
        detailModuel.movie = movie
        navigationConroller.pushViewController(detailModuel, animated: true)
    }
}
