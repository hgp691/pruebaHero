//
//  NetworkService.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/21/18.
//  Copyright © 2018 hero. All rights reserved.
//

import Foundation


class NetworkService{
    
    static func obtenerVenues(filtro: String){
        print("Hola")
        
        var urlComponent = URLComponents(string: "https://api.foursquare.com/v2/venues/search")
        urlComponent?.queryItems = [
            URLQueryItem(name: "client_id", value: "L5IVTR5VX30JSL0U42XWNHUHMAVPPJCOEJBQ1CRF0B1BAPCK"),
            URLQueryItem(name: "client_secret", value: "OAXWRFI2AWTVFCHN3HKYWKRW3DF5DW2OL12GE4BRANQQSZ5K"),
            URLQueryItem(name: "ll", value: "40.7243,-74.0018")
        ]
        
    }
    
    
}
