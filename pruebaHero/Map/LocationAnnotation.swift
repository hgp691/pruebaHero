//
//  LocationAnnotation.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/24/18.
//  Copyright © 2018 hero. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var id: String
    var categorieId: String
    
    init(venue: Venue){
        self.coordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
        self.title = venue.name
        self.subtitle = venue.location.address
        self.id = venue.id
        self.categorieId = venue.categories.first?.id ?? ""
    }
    
}
