//
//  DetailScreenPresenter.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit

protocol DetailScreenPresenterPresentationLogic {
    func presentFetchedPhoto(response : PhotoUrl.GetUrl.Response)
}

class DetailScreenPresenter: DetailScreenPresenterPresentationLogic {
    weak var viewController :  DetailScreenViewController?
    
    func presentFetchedPhoto(response : PhotoUrl.GetUrl.Response) {
        if let message = response.message{
            viewController?.displayError(message)
        }
        
        viewController?.photoData = response.photoData
    }
}
