//
//  LocationService.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/20/18.
//  Copyright © 2018 hero. All rights reserved.
//

import Foundation
import CoreLocation


class LocationService: NSObject{
    
    static let shared = LocationService()
    
    private var locationManager = CLLocationManager()
    
    private var lastLocation: CLLocation?
    
    private override init() {
        super.init()
    }
    
    func configurarLocationService(){
        if CLLocationManager.locationServicesEnabled() == true{
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined{
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
        }else{
            print("Debe activar la localización")
        }
    }
    
}


extension LocationService: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error locationmanager: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Coord obtenida: ")
        self.lastLocation = locations.last
    }
    
}
