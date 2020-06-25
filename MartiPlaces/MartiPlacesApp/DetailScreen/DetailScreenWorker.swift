//
//  DetailScreenWorker.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import Foundation
import PromiseKit

class DetailScreenWorker {
    
    func getPhoto(photoRef : String) -> Promise<UIImage>{
        
        return Promise { seal in
            let urlString = "\(Constants.photoBaseUrl)?maxwidth=300&photoreference=\(photoRef)&key=\(Constants.apiKey)"
            
            if let url = URL(string: urlString)
            {
                let urlRequest = URLRequest(url: url)
                NSURLConnection.sendAsynchronousRequest(urlRequest, queue: OperationQueue.main, completionHandler: {(response, data, error) in
                    if let data = data
                    {
                        let image = UIImage(data: data)
                        seal.fulfill(image!)
                    }
                    else
                    {
                        let image = UIImage(named: "placeholder")
                        seal.fulfill(image!)
                    }
                })
            }
        }
    }
}
