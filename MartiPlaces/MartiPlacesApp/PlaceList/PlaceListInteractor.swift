//
//  PlaceListInteractor.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit

protocol PlaceListBusinessLogic {
    func searchPlaces(text : String)
}

protocol PlaceListDataStore {
    //var name: String { get set }
}

class PlaceListInteractor: PlaceListBusinessLogic, PlaceListDataStore {
    
    var presenter : PlaceListPresentationLogic?
    var worker : PlaceListWorker? = PlaceListWorker()
    
    var places : SearchResult?
    
    func searchPlaces(text : String) {
        worker?.fetchPlaceList(text: text).done{ (response) -> Void in
            self.places = response
            let result = PlaceList.GetPlaces.Response(placeList: self.places, message: nil)
            self.presenter?.presentFetchedPlaces(response: result)
        }.catch({ (error) in
            let result = PlaceList.GetPlaces.Response(placeList: self.places, message: error.localizedDescription)
            self.presenter?.presentFetchedPlaces(response: result)
        })
    }
    
    
}
