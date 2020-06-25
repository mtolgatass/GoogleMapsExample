//
//  MapScreenRouter.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit

@objc protocol MapScreenRoutingLogic {
    func popViewController()
    func push(storyboardName : String, withIdentifier : String, setupBlock: ((UIViewController) -> Void)?)
}

protocol MapScreenDataPassing {
    var dataStore: MapScreenDataStore? { get }
}

class MapScreenRouter: NSObject, MapScreenRoutingLogic, MapScreenDataPassing {
    weak var viewController : MapScreenViewController?
    var dataStore: MapScreenDataStore?
    
    func popViewController() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func push(storyboardName: String, withIdentifier: String, setupBlock: ((UIViewController) -> Void)?) {
        viewController?.push(storyboardName: storyboardName, withIdentifier: withIdentifier, setupBlock: setupBlock)
    }
}
