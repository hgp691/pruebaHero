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
    
    func configureLocationService(){
        if CLLocationManager.locationServicesEnabled() == true{
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined{
                locationManager.requestWhenInUseAuthorization()
            }
            
            
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
                locationManager.startUpdatingLocation()
            }
            
        }else{
            //print("You must activate the location")
            NotificationCenter.default.post(name: Notification.Name(LocationMessages.LOCATION_UPDATE_AUTH_ERROR.rawValue), object: nil, userInfo: ["Error": RuntimeError("You need to allow location services")])
        }
    }
    
    func getCoordinateAsString()->String{
        return "\(String(describing: (self.lastLocation?.coordinate.latitude)!)),\(String(describing: (self.lastLocation?.coordinate.longitude)!))"
    }
    
    func getDistance(toCoordinate coordinate:CLLocationCoordinate2D)->Double{
        let coord = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return (self.lastLocation?.distance(from: coord))!
    }
    
}


extension LocationService: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //print("Authorization update")
        
        if status != .authorizedWhenInUse{
            NotificationCenter.default.post(name: Notification.Name(LocationMessages.LOCATION_UPDATE_AUTH_ERROR.rawValue), object: nil, userInfo: ["Error": RuntimeError("You need to allow location services")])
            
        }else{
            locationManager.startUpdatingLocation()
            NotificationCenter.default.post(name: Notification.Name(LocationMessages.LOCATION_UPDATE_AUTH.rawValue), object: nil, userInfo: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //print("Error locationmanager: \(error.localizedDescription)")
        NotificationCenter.default.post(name: Notification.Name(LocationMessages.LOCATION_UPDATE_AUTH_ERROR.rawValue), object: nil, userInfo: ["Error": error])
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
        if self.lastLocation == nil{
            self.lastLocation = locations.last
            NotificationCenter.default.post(name: Notification.Name(LocationMessages.FIRST_LOCATION_UPDATE.rawValue), object: nil, userInfo: nil)
        }else{
            self.lastLocation = locations.last
            NotificationCenter.default.post(name: Notification.Name(LocationMessages.LOCATION_UPDATE.rawValue), object: nil, userInfo: nil)
        }
        
    }
    
}

enum LocationMessages: String{
    case LOCATION_UPDATE_AUTH_ERROR = "LOCATION_UPDATE_AUTH_ERROR"
    case LOCATION_UPDATE_AUTH = "LOCATION_UPDATE_AUTH"
    case LOCATION_UPDATE = "LOCATION_UPDATE"
    case FIRST_LOCATION_UPDATE = "FIRST_LOCATION_UPDATE"
}
