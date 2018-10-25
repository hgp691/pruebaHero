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
    
    private var lastAutomaticUpdated:Bool = false
    
    init(){ }
    
    func initialLoad(completion: @escaping (Error?)->Void){
        
        if self.lastAutomaticUpdated == false{
            NetworkService.loadVenues {[weak self] (error, venuesReturned) in
                if error != nil{
                    completion(error)
                }else{
                    self?.lastAutomaticUpdated = true
                    venuesReturned.forEach({[weak self] (ven) in
                        self?.pushVenueToInitial(venue: ven)
                    })
                    completion(nil)
                }
            }
        }else{
            if self.venues.count > 0{
                completion(nil)
            }else{
                NetworkService.loadVenues {[weak self] (error, venuesReturned) in
                    if error != nil{
                        completion(error)
                    }else{
                        self?.lastAutomaticUpdated = true
                        venuesReturned.forEach({[weak self] (ven) in
                            self?.pushVenueToInitial(venue: ven)
                        })
                        completion(nil)
                    }
                }
            }
            
        }
        
    }
    
    private func pushVenueToInitial(venue: Venue){
        if self.venueExists(venue: venue) == false{
            self.venues.append(venue)
        }
    }
    
    private func venueExists(venue: Venue)->Bool{
        for ven in self.venues{
            if ven.id == venue.id{
                return true
            }
        }
        return false
    }
    
    func venueViewModelForIndexpath(indexPath: IndexPath)->VenueCellViewModel{
        return VenueCellViewModel(venue: self.venues[indexPath.row])
    }
    
}
