//
//  Navegacion.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/23/18.
//  Copyright © 2018 hero. All rights reserved.
//

import Foundation
import UIKit

class Navegation{
    
    var window: UIWindow?
    var tabController: TabBarViewController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func ponerTabBar(){
        self.tabController = TabBarViewController()
        
        
    }
    
}
