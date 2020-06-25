//
//  MapScreenInteractor.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit

protocol MapScreenBusinessLogic {
    
}

protocol MapScreenDataStore {
    //var name: String { get set }
}

class MapScreenInteractor: MapScreenBusinessLogic, MapScreenDataStore {
    var presenter : MapScreenPresenter?
    var worker : MapScreenWorker? = MapScreenWorker()
}
