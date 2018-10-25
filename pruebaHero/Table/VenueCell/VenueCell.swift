//
//  VenueCell.swift
//  prueba
//
//  Created by Horacio Guzman on 10/22/18.
//  Copyright © 2018 Horacio Guzman. All rights reserved.
//

import UIKit

class VenueCell: UITableViewCell {
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var direccion: UILabel!
    @IBOutlet weak var icono: UIImageView!
    @IBOutlet weak var categoria: UIImageView!
    
    var venueCellViewModel: VenueCellViewModel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    func setup(venueCellViewModel: VenueCellViewModel){
        
        self.venueCellViewModel = venueCellViewModel
        self.nombre.text = self.venueCellViewModel.nombre
        self.direccion.text = self.venueCellViewModel.direccion
        self.icono.image = self.venueCellViewModel.icono
        self.selectionStyle = .none
        
        self.venueCellViewModel.cargarIcono(completion: {[weak self] in
            DispatchQueue.main.async {
                self?.icono.image = self?.venueCellViewModel.icono
            }
        })
        
        self.venueCellViewModel.cargarIconoCategoria {[weak self] (cargo) in
            
            print("Cargo: Icono")
            
            if cargo{
                DispatchQueue.main.async {
                    self?.categoria.backgroundColor = Theme.mainColor
                    self?.categoria.image = self?.venueCellViewModel.iconoCategoria
                }
            }
        }
        
    }
    
}
