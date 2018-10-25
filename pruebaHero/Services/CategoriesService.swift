//
//  CategoriesService.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/24/18.
//  Copyright © 2018 hero. All rights reserved.
//

import Foundation
import UIKit

class CategoriesService{
    
    static let shared = CategoriesService()
    
    var categories: [Category] = []
    
    private init(){ }
    
    func load(completion: @escaping ()->Void){
        if self.categories.isEmpty{
            NetworkService.loadCategories {[weak self] (categories) in
                self?.categories = categories
                completion()
            }
        }else{
            completion()
        }
    }
    
    func setImageForId(image: UIImage, id: String){
        self.categories.forEach { (category) in
            if category.id == id{
                category.iconDef = image
            }else{
                category.categories.forEach({ (subcategory) in
                    if subcategory.id == id{
                        category.iconDef = image
                    }
                })
            }
        }
    }
    
    func imageForId(id: String)->UIImage?{
        for category in self.categories{
            if category.id == id{
                return category.iconDef
            }else{
                for subCategory in category.categories{
                    if subCategory.id == id{
                        return category.iconDef
                    }
                }
            }
        }
        return nil
    }
    
    func imageUrlForId(id: String)->String{
        for category in self.categories{
            if category.id == id{
                return category.iconURL
            }else{
                for subCategory in category.categories{
                    if subCategory.id == id{
                        return category.iconURL
                    }
                }
            }
        }
        return ""
    }
    
}

