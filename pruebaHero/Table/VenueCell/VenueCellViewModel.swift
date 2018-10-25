//
//  VenueCellViewModel.swift
//  prueba
//
//  Created by Horacio Guzman on 10/22/18.
//  Copyright © 2018 Horacio Guzman. All rights reserved.
//

import Foundation
import UIKit

class VenueCellViewModel{
    
    public var nombre: String?
    public var direccion: String?
    public var icono: UIImage?
    public var iconoCategoria: UIImage?
    
    var venue: Venue
    
    init(venue: Venue) {
        self.venue = venue
        self.nombre = self.venue.name
        self.direccion = self.venue.location.address
        self.icono = self.venue.icono ?? self.venue.placeHolder
    }
    
    func cargarIcono(completion: @escaping ()->Void){
        
        NetworkService.loadVenuesPhotosByID(venue_id: self.venue.id, completion: {[weak self] (photos) in
            if photos?.first != nil{
                NetworkService.loadImage(byVenuePhoto: (photos?.first)!, andSize: "200x200", completion: {[weak self] (imagen) in
                    self?.icono = imagen
                    self?.venue.icono = imagen
                    completion()
                })
            }else{
                print("No hay first")
                self?.icono = UIImage(named: "camerabroken")!
                completion()
            }
        })
    }
    
    func cargarIconoCategoria(completion: @escaping (Bool)->Void){
        if let imagen = CategoriesService.shared.imageForId(id: venue.categories.first?.id ?? ""){
            self.iconoCategoria = imagen
            completion(true)
        }else{
            let imagenURL = CategoriesService.shared.imageUrlForId(id: venue.categories.first?.id ?? "")
            if imagenURL.isEmpty == false{
                
                NetworkService.loadImageByURL(url: imagenURL) {[weak self] (image) in
                    self?.iconoCategoria = image
                    completion(true)
                }
                
            }else{
                completion(false)
            }
        }
    }
    
}
