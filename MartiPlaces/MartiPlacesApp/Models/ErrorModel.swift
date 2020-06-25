//
//  ErrorModel.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import Foundation

enum ErrorModel: Error {
    case networkError
}

extension ErrorModel: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkError:
            return NSLocalizedString("Description of network error", comment: "Network Error")
        }
    }
}
