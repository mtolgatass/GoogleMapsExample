//
//  DetailScreenInteractor.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit

protocol DetailScreenBusinessLogic {
    func getPhotoUrl(photoRef : String)
}

protocol DetailScreenDataStore {
    //var name: String { get set }
}

class DetailScreenInteractor: DetailScreenBusinessLogic, DetailScreenDataStore {
    var presenter : DetailScreenPresenter?
    var worker : DetailScreenWorker? = DetailScreenWorker()
    
    var data : UIImage!
    
    func getPhotoUrl(photoRef: String) {
        worker?.getPhoto(photoRef: photoRef).done({ (response) -> Void in
            self.data = response
            
            let result = PhotoUrl.GetUrl.Response(photoData : self.data)
            self.presenter?.presentFetchedPhoto(response: result)
        })
    }
}
