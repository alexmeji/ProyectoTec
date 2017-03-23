//
//  AlimentosCell.swift
//  ProyectoTec
//
//  Created by Alex Mejicanos on 22/03/17.
//  Copyright © 2017 Alex Mejicanos. All rights reserved.
//

import UIKit

class AlimentosCell: UICollectionViewCell {
    
    @IBOutlet var picture: UIImageView?
    @IBOutlet var name: UILabel?
    @IBOutlet var price: UILabel?
    @IBOutlet var backView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
