//
//  PlaceListRouter.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit

@objc protocol PlaceListRoutingLogic {
    func push(storyboardName : String, withIdentifier : String, setupBlock: ((UIViewController) -> Void)?)
}

protocol PlaceListDataPassing {
    var dataStore: PlaceListDataStore? { get }
}

class PlaceListRouter: NSObject, PlaceListRoutingLogic, PlaceListDataPassing {
    weak var viewController: PlaceListViewController?
    var dataStore: PlaceListDataStore?
    
    func push(storyboardName: String, withIdentifier: String, setupBlock: ((UIViewController) -> Void)?) {
        viewController?.push(storyboardName: storyboardName, withIdentifier: withIdentifier, setupBlock: setupBlock)
    }
}
