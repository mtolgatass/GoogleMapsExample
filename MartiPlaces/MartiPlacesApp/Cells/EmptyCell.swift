//
//  EmptyCell.swift
//  MartiPlacesApp
//
//  Created by MUSTAFA TOLGA TAS on 23.06.2020.
//  Copyright © 2020 MUSTAFA TOLGA TAS. All rights reserved.
//

import UIKit

class EmptyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
