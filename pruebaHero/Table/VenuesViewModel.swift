//
//  VenuesViewModel.swift
//  prueba
//
//  Created by Horacio Guzman on 10/22/18.
//  Copyright © 2018 Horacio Guzman. All rights reserved.
//

import Foundation


class VenuesViewModel{
    
    var venues:[Venue] = [Venue]()
    
    
    init(){ }
    
    func initialLoad(completion: @escaping (Error?)->Void){
        
        NetworkService.loadVenues {[weak self] (error, venuesReturned) in
            if error != nil{
                completion(error)
            }else{
                
                print("Se obtuvieron \(venuesReturned.count)")
                
                self?.venues = venuesReturned
                completion(nil)
            }
        }
        
    }
    
    func venueViewModelForIndexpath(indexPath: IndexPath)->VenueCellViewModel{
        return VenueCellViewModel(venue: self.venues[indexPath.row])
    }
    
    func searchVenuesByCategoryId(categoryId: String, completion: @escaping (Error?)->Void){
        
        NetworkService.searchVenuesByCategory(categoryId: categoryId) {[weak self] (error, venuesReturned) in
            if error != nil{
                completion(error)
            }else{
                
                print("Se obtuvieron \(venuesReturned.count)")
                
                self?.venues = venuesReturned
                completion(nil)
            }
        }
        
    }
    
}
