//
//  PlaceListWorker.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import ObjectMapper

class PlaceListWorker {
    
    func fetchPlaceList(text : String) -> Promise<SearchResult>{
        
        let parameters : Parameters = [
            "input" : text,
            "inputtype" : "textquery",
            "fields" : "photos,formatted_address,name,rating,opening_hours,geometry",
            "key" : Constants.apiKey]
        
        return Promise { seal in
            AF.request(Constants.searchBaseUrl, method: .get, parameters: parameters)
                .validate()
                .responseJSON { response in
                    switch response.result{
                    case .success (_):
                        do{
                            let places = try JSONDecoder().decode(SearchResult.self, from: response.data!)
                            seal.fulfill(places)
                        }catch{
                            let error : ErrorModel = ErrorModel.networkError
                            seal.reject(error)
                        }
                    case .failure(let error):
                        seal.reject(error)
                    }
                    
                    //                    if let data = response.result{
                    
                    
                    //                        do{
                    //                            let result = try JSONDecoder().decode(SearchResult.self, from: data)
                    //                            seal.fulfill(result)
                    //                        } catch {
                    //                            let error : ErrorModel = ErrorModel.networkError
                    //                            seal.reject(error)
                    //                        }
                    //                    }
            }
            
        }
    }
}
