//
//  RestaurantAnnotation.swift
//  ProyectoTec
//
//  Created by Alex Mejicanos on 29/03/17.
//  Copyright © 2017 Alex Mejicanos. All rights reserved.
//

import UIKit
import MapKit

class RestaurantAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var image: UIImage?
    let coordinate: CLLocationCoordinate2D
    var tag: Int?
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, tag: Int) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.tag = tag
        
        super.init()
    }
    
    
}
