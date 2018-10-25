//
//  VenueCategorie.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/24/18.
//  Copyright © 2018 hero. All rights reserved.
//

import Foundation
import UIKit

final class Category: Codable{
    
    var id: String
    var name: String
    var pluralName: String
    var shortName: String
    var iconURL: String
    var iconDef: UIImage?
    var categories: [SubCategory]
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: VenueCategorieKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.pluralName = try container.decode(String.self, forKey: .pluralName)
        self.shortName = try container.decode(String.self, forKey: .shortName)
        
        let icon = try container.nestedContainer(keyedBy: VenueCategorieKeys.self, forKey: .icon)
        let prefix = try icon.decode(String.self, forKey: .prefix)
        let suffix = try icon.decode(String.self, forKey: .suffix)
        
        self.categories = try container.decode([SubCategory].self, forKey: .categories)
        
        let url = "\(prefix)88\(suffix)"
        self.iconURL = url
        
    }
    
    func encode(to encoder: Encoder) throws {
        //TODO: ENCODABLE
        
    }
    
    enum VenueCategorieKeys: String, CodingKey{
        case id
        case name
        case pluralName
        case shortName
        case icon
        case prefix
        case suffix
        case categories
    }
    
}
