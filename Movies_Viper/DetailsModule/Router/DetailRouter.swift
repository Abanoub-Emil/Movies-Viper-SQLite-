//
//  DetailRouter.swift
//  Movies_Viper
//
//  Created by Mai Hassan on 2/11/19.
//  Copyright © 2019 Abanoub Ghaly. All rights reserved.
//


import UIKit

class DetailRouter: DetailRouterProtocol {
    
    static func createModule() -> DetailViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let presenter: DetailPresenterProtocol = DetailPresenter()
        let interactor: DetailInteractorProtocol = DetailInteractor()
        let router: DetailRouterProtocol = DetailRouter()
        
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
    
}

