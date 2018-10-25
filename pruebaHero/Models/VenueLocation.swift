//
//  VenueLocation.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/24/18.
//  Copyright © 2018 hero. All rights reserved.
//

import Foundation
import CoreLocation

class VenueLocation: Codable{
    
    var address: String?
    var lat: Double
    var lng: Double
    var distance: Double
    var formattedAddress: [String]
    
    func locationCoordinate()->CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: self.lat, longitude: self.lng)
    }
    
}
