//
//  DetailScreenRouter.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import Foundation

@objc protocol DetailScreenRoutingLogic {
    func popViewController()
}

protocol DetailScreenDataPassing {
    var dataStore: DetailScreenDataStore? { get }
}

class DetailScreenRouter: NSObject, DetailScreenRoutingLogic, DetailScreenDataPassing {
    weak var viewController: DetailScreenViewController?
    var dataStore: DetailScreenDataStore?
    
    func popViewController() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}

