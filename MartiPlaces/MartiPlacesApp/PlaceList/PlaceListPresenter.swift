//
//  PlaceListPresenter.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit

protocol PlaceListPresentationLogic {
    func presentFetchedPlaces(response: PlaceList.GetPlaces.Response)
}

class PlaceListPresenter: PlaceListPresentationLogic {
    weak var viewController : PlaceListViewController?
    
    func presentFetchedPlaces(response: PlaceList.GetPlaces.Response) {
        if let message = response.message{
            viewController?.displayError(message)
        }
        guard let model = response.placeList else {
            viewController?.displayEmpty(response.message ?? "")
            return
        }
        let placeListViewModel = PlaceListViewModel(resultModel: model)
        let viewModel = PlaceList.GetPlaces.ViewModel(displayResults: placeListViewModel)
        viewController?.displayPlaces(viewModel: viewModel)
        
    }
}
