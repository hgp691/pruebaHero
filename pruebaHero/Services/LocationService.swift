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
    
    private(set) var available: Bool = false
    
    private var locationManager = CLLocationManager()
    
    private var lastLocation: CLLocation?
    
    lazy var authorized:Bool = {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            return true
        }else{
            return false
        }
    }()
    
    private override init() {
        super.init()
    }
    
    func configureLocationService(){
        if CLLocationManager.locationServicesEnabled() == true{
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined{
                locationManager.requestWhenInUseAuthorization()
            }else{
                self.available = true
            }
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
                locationManager.startUpdatingLocation()
            }else{
                print("Send LOCATION_UPDATE_AUTH_ERROR")
            }
        }else{
            print("You must activate the location")
            NotificationCenter.default.post(name: Notification.Name(LocationMessages.LOCATION_UPDATE_AUTH_ERROR.rawValue), object: nil, userInfo: ["Error": RuntimeError("You need to allow location services")])
        }
    }
    
    func getCoordinateAsString()->String{
        print(self.lastLocation)
        return "\(String(describing: (self.lastLocation?.coordinate.latitude)!)),\(String(describing: (self.lastLocation?.coordinate.longitude)!))"
    }
    
}


extension LocationService: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization update")
        
        if status != .authorizedWhenInUse{
            NotificationCenter.default.post(name: Notification.Name(LocationMessages.LOCATION_UPDATE_AUTH_ERROR.rawValue), object: nil, userInfo: ["Error": RuntimeError("You need to allow location services")])
            
        }else{
            locationManager.startUpdatingLocation()
            NotificationCenter.default.post(name: Notification.Name(LocationMessages.LOCATION_UPDATE_AUTH.rawValue), object: nil, userInfo: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error locationmanager: \(error.localizedDescription)")
        NotificationCenter.default.post(name: Notification.Name(LocationMessages.LOCATION_UPDATE_AUTH_ERROR.rawValue), object: nil, userInfo: ["Error": error])
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
        self.available = true
        self.lastLocation = locations.last
        NotificationCenter.default.post(name: Notification.Name(LocationMessages.LOCATION_UPDATE.rawValue), object: nil, userInfo: nil)
    }
    
}

enum LocationMessages: String{
    case LOCATION_UPDATE_AUTH_ERROR = "LOCATION_UPDATE_AUTH_ERROR"
    case LOCATION_UPDATE_AUTH = "LOCATION_UPDATE_AUTH"
    case LOCATION_UPDATE = "LOCATION_UPDATE"
}
