//
//  CategorySelectorCellViewModel.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/25/18.
//  Copyright © 2018 hero. All rights reserved.
//

import Foundation
import UIKit

class CategorySelectorCellViewModel{
    
    var category: Category
    var name: String
    var image: UIImage?
    var id: String
    
    init (category: Category){
        self.category = category
        self.name = category.name
        self.image = CategoriesService.shared.imageForId(id: category.id)
        self.id = category.id
    }
    
}
