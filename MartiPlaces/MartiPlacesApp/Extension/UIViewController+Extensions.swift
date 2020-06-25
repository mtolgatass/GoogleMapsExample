//
//  UIViewController+Extensions.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 24.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func push(storyboardName: String, withIdentifier: String, setupBlock: ((UIViewController) -> Void)? = nil) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: withIdentifier)
        setupBlock?(viewController)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}


