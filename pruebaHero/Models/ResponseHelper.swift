//
//  ResponseHelper.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/24/18.
//  Copyright © 2018 hero. All rights reserved.
//

import Foundation


final class ResponseHelperVenueCategories: Codable{
    
    var code: Int
    var categories: [Category]
    
    init(from decoder:Decoder) throws{
        
        let container = try decoder.container(keyedBy: ResponseHelperVenueCategoriesKeys.self)
        let meta = try container.nestedContainer(keyedBy: ResponseHelperVenueCategoriesKeys.self, forKey: .meta)
        self.code = try meta.decode(Int.self, forKey: .code)
        if self.code == 200{
            let response = try container.nestedContainer(keyedBy: ResponseHelperVenueCategoriesKeys.self, forKey: .response)
            self.categories = try response.decode([Category].self, forKey: .categories)
        }else{
            self.categories = []
        }
    }
    
    
    enum ResponseHelperVenueCategoriesKeys: String, CodingKey{
        case meta
        case code
        case response
        case categories
    }
    
}


final class ResponseHelperVenue: Codable{
    var venues: [Venue]
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: ResponseHelperVenueKeys.self)
        let response = try container.nestedContainer(keyedBy: ResponseHelperVenueKeys.self, forKey: .response)
        self.venues = try response.decode([Venue].self, forKey: .venues)
        
    }
    
    enum ResponseHelperVenueKeys: String, CodingKey{
        case response
        case venues
    }
    
}

final class ResponseHelperVenuePhoto: Codable{
    
    var code: Int
    var items: [VenuePhoto]
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: ResponseHelperVenuePhotoKeys.self)
        let meta = try container.nestedContainer(keyedBy: ResponseHelperVenuePhotoKeys.self, forKey: .meta)
        self.code = try meta.decode(Int.self, forKey: .code)
        if self.code == 200{
            do{
                let response = try container.nestedContainer(keyedBy: ResponseHelperVenuePhotoKeys.self, forKey: .response)
                let photos = try response.nestedContainer(keyedBy: ResponseHelperVenuePhotoKeys.self, forKey: .photos)
                self.items = try photos.decode([VenuePhoto].self, forKey: .items)
            }catch{
                //print("Error ResponseHelperVenuePhoto decoder: \(error.localizedDescription)")
                self.items = []
            }
        }else{
            self.items = []
        }
        
    }
    
    enum ResponseHelperVenuePhotoKeys: String, CodingKey{
        case meta
        case code
        case response
        case photos
        case items
    }
    
}
