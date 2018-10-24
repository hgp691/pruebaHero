//
//  ViewController.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/20/18.
//  Copyright © 2018 hero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LocationService.shared.configurarLocationService()
        
        NetworkService.obtenerVenues(filtro: "Hey")
        
    }


}

