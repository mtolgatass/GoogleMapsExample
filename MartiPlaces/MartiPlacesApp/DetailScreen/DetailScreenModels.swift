//
//  DetailScreenModels.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit
enum PhotoUrl {
    enum GetUrl {
        struct Request {
        }
        
        struct Response {
            var photoData : UIImage
            var message : String?
        }
        
        struct ViewModel {
            var photoData: UIImage
        }
        
    }
}
