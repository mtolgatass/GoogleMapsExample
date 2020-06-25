//
//  PlaceListViewModel.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import Foundation

final class PlaceListViewModel {
    
    var resultModel : SearchResult!
    
    private(set) var candidates : [Candidates]!
    private(set) var status : String!
    
    init(resultModel : SearchResult) {
        self.resultModel = resultModel
        self.candidates = resultModel.candidates
        self.status = resultModel.status
    }
}
