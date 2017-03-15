//
//  RestaurantCell.swift
//  ProyectoTec
//
//  Created by Alex Mejicanos on 15/03/17.
//  Copyright © 2017 Alex Mejicanos. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet var picture: UIImageView?
    @IBOutlet var name: UILabel?
    @IBOutlet var info: UILabel?
    @IBOutlet var star_1: UIImageView?
    @IBOutlet var star_2: UIImageView?
    @IBOutlet var star_3: UIImageView?
    @IBOutlet var star_4: UIImageView?
    @IBOutlet var star_5: UIImageView?
    @IBOutlet var money_1: UIImageView?
    @IBOutlet var money_2: UIImageView?
    @IBOutlet var money_3: UIImageView?
    @IBOutlet var money_4: UIImageView?
    @IBOutlet var money_5: UIImageView?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codes
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
