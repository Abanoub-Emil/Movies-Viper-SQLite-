//
//  DetailPresenter.swift
//  Movies_Viper
//
//  Created by Mai Hassan on 2/11/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//

import UIKit

class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    
    func getVideoKey(url: String) {
        interactor?.getVideoKey(URL: url, success: { [weak self] (videoURL) in
            self?.view?.openTrailerVideo(url: videoURL)
        }, failure: { (error) in
            print(error)
        })
    }
    
}
