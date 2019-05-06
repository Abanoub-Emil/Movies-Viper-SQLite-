//
//  DetailsModuleProtocols.swift
//  Movies_Viper
//
//  Created by Mai Hassan on 2/11/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//


import UIKit

protocol DetailViewProtocol: class {
    var presenter: DetailPresenterProtocol? {get set}
    func openTrailerVideo(url: String)
}


protocol DetailPresenterProtocol: class {
    var view: DetailViewProtocol? {get set}
    var interactor: DetailInteractorProtocol? {get set}
    var router: DetailRouterProtocol? {get set}
    func getVideoKey(url: String)

}


protocol DetailInteractorProtocol: class {
    //    var observable: Observable<String> {get}
    var presenter: DetailPresenterProtocol? {get set}
    func getVideoKey(URL: String, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void)

}

protocol DetailRouterProtocol: class {
    static func createModule()-> DetailViewController
    
}
