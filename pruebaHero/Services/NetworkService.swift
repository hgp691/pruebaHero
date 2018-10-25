//
//  NetworkService.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/24/18.
//  Copyright © 2018 hero. All rights reserved.
//

import Foundation
import UIKit


class NetworkService{
    
    //MARK: LOAD CATEGORIES
    static func loadCategories(completion: @escaping ([Category])->Void){
        
        let urlString = "https://api.foursquare.com/v2/venues/categories"
        
        var urlComponents = URLComponents(string: urlString)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "L5IVTR5VX30JSL0U42XWNHUHMAVPPJCOEJBQ1CRF0B1BAPCK"),
            URLQueryItem(name: "client_secret", value: "OAXWRFI2AWTVFCHN3HKYWKRW3DF5DW2OL12GE4BRANQQSZ5K"),
            URLQueryItem(name: "v", value: "20180323")
        ]
        
        let request = URLRequest(url: urlComponents!.url!)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            do{
                
                if let errorObtenido = error{
                    throw errorObtenido
                }
                
                guard let data = data else{
                    throw RuntimeError("No se pudo obtener data")
                }
                
                let decoder = JSONDecoder()
                let helper = try decoder.decode(ResponseHelperVenueCategories.self, from: data)
                
                completion(helper.categories)
                
            }catch{
                //print("Error cargando categorias: \(error.localizedDescription)")
                completion([])
            }
        }
        task.resume()
        
    }
    
    //MARK: LOAD VENUES
    static func loadVenues(completion: @escaping (Error?,[Venue])->Void){
        
        var urlComponents = URLComponents(string: "https://api.foursquare.com/v2/venues/search")
        
        let stringLocation = LocationService.shared.getCoordinateAsString()
        
        print("Load venues of \(stringLocation)")
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "L5IVTR5VX30JSL0U42XWNHUHMAVPPJCOEJBQ1CRF0B1BAPCK"),
            URLQueryItem(name: "client_secret", value: "OAXWRFI2AWTVFCHN3HKYWKRW3DF5DW2OL12GE4BRANQQSZ5K"),
            URLQueryItem(name: "v", value: "20180323"),
            URLQueryItem(name: "ll", value: stringLocation),
            URLQueryItem(name: "limit", value: "30"),
            URLQueryItem(name: "radius", value: "200")
        ]
        
        let request = URLRequest(url: urlComponents!.url!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            do{
                
                if let loadError = error{
                    throw loadError
                }
                
                guard let data = data else{
                    throw RuntimeError("Error loading venues")
                }
                
                
                
                ////print(String(data: data, encoding: String.Encoding.utf8))
                
                let decoder = JSONDecoder()
                let helper = try decoder.decode(ResponseHelperVenue.self, from: data)
                print("Venues a pintar: \(helper.venues.count)")
                completion(nil, helper.venues)
                
                
            }catch{
                completion(error, [])
            }
            
        }
        
        task.resume()
        
    }
    
    //MARK: LOAD VENUEPHOTOS BY VENUE ID
    static func loadVenuesPhotosByID(venue_id: String, completion: @escaping ([VenuePhoto]?)->Void){
        
        let urlString = "https://api.foursquare.com/v2/venues/\(venue_id)/photos"
        
        var urlComponents = URLComponents(string: urlString)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "L5IVTR5VX30JSL0U42XWNHUHMAVPPJCOEJBQ1CRF0B1BAPCK"),
            URLQueryItem(name: "client_secret", value: "OAXWRFI2AWTVFCHN3HKYWKRW3DF5DW2OL12GE4BRANQQSZ5K"),
            URLQueryItem(name: "v", value: "20180323")
        ]
        
        let request = URLRequest(url: urlComponents!.url!)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            do{
                
                ////print("Error de la consulta: \(error?.localizedDescription)")
                
                if let errorObtenido = error{
                    throw errorObtenido
                }
                
                guard let data = data else{
                    throw RuntimeError("No se pudo obtener data")
                }
                
                let decoder = JSONDecoder()
                let helper = try decoder.decode(ResponseHelperVenuePhoto.self, from: data)
                
                completion(helper.items)
                
                
            }catch{
                //print("Error cargando fotos cargarImagenesVenue \(error.localizedDescription) para la url: \(urlString)")
                completion(nil)
            }
        }
        task.resume()
        
    }
    
    //TODO: move the image load to an UIIMAGEVIEW extension
    //TODO: validate size of the image
    //MARK: LOAD IMAGE FOR VENUE
    static func loadImage(byVenuePhoto venuePhoto: VenuePhoto,andSize size: String,completion: @escaping (UIImage)->Void){
        
        let urlString = "\(String(describing: venuePhoto.prefix!))\(size)\(String(describing: venuePhoto.suffix!))"
        
        print("Load image: \(urlString) ")
        
        
        let request = URLRequest(url: URL(string: urlString)!)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            do{
                
                if let loadingError = error{
                    throw loadingError
                }
                
                guard let data = data else{
                    throw RuntimeError("Error loading venues")
                }
                
                let image = UIImage(data: data)
                completion(image!)
                
            }catch{
                //print("Error loading loadImageForVenue \(error.localizedDescription)")
                completion(UIImage(named: "camerabroken")!)
            }
        }
        task.resume()
        
    }
    
    //MARK: LOAD IMAGE FOR CATEGORY
    static func loadImageByURL(url:String, completion: @escaping (UIImage)->Void){
        let urlString = "\(url)"
        
        //print("load image: \(urlString) ")
        
        
        let request = URLRequest(url: URL(string: urlString)!)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            do{
                
                if let loadError = error{
                    throw loadError
                }
                
                guard let data = data else{
                    throw RuntimeError("Error loading image by url")
                }
                
                let image = UIImage(data: data)
                completion(image!)
                
            }catch{
                //print("Error loading cargarImageForVenue \(error.localizedDescription)")
                completion(UIImage(named: "camerabroken")!)
            }
        }
        task.resume()
    }
    
}
