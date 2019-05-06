//
//  DetailInteractor.swift
//  Movies_Viper
//
//  Created by Mai Hassan on 2/11/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailInteractor: DetailInteractorProtocol {
    
    weak var presenter: DetailPresenterProtocol?
    
    // UnComment If we used RxSwift
    //    var myResult = Variable<String>("")
    //    var observable: Observable<String> {
    //        return myResult.asObservable()
    //}
    func getVideoKey(URL: String, success: @escaping (String) -> Void, failure: @escaping (Error) -> Void) {
        AFWrapper.requestGETURL(URL, success: { (json) in
            let keys = JSON(json["results"]).arrayValue
            
            success("https://www.youtube.com/watch?v=" + keys[0]["key"].stringValue)
        }) { (Error) in
            failure(Error)
        }
    }
}
