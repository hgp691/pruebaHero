//
//  Venue.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/24/18.
//  Copyright © 2018 hero. All rights reserved.
//

import Foundation
import UIKit


final class Venue: Codable{
    
    var id: String
    var name: String
    var location: VenueLocation
    var icono: UIImage?
    var placeHolder: UIImage
    var categories: [VenueLocalCategory]
    
    required init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: VenueKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.location = try container.decode(VenueLocation.self, forKey: .location)
        self.placeHolder = UIImage(named: "camera")!
        self.categories = try container.decode([VenueLocalCategory].self, forKey: .categories)
    }
    
    func encode(to encoder: Encoder) throws {
        //TODO: encode
    }
    
    enum VenueKeys: String, CodingKey{
        case id
        case name
        case location
        case categories
    }
}

class VenueLocalCategory: Codable{
    
    var id: String
    var name: String
    
}
