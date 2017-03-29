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
    let name: String
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(name: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    
}
