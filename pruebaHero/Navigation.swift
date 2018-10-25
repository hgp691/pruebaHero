//
//  Navegacion.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/23/18.
//  Copyright © 2018 hero. All rights reserved.
//

import Foundation
import UIKit

class Navigation{
    
    var MapVC: MapViewController?
    var TableVC: TableViewController?
    
    var window: UIWindow?
    var tabController: TabBarViewController?
    
    init(window: UIWindow) {
        self.window = window
        
        CategoriesService.shared.load {[weak self] in
            DispatchQueue.main.async {
                self?.showTabBar()
            }
        }
        
    }
    
    func showTabBar(){
        
        print("Show tabbar")
        
        self.tabController = TabBarViewController()
        
        self.MapVC = UIStoryboard(name: "Map", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
        let MapNC = UINavigationController(rootViewController: MapVC!)
        MapNC.configureVisualNavBar()
        self.TableVC = UIStoryboard(name: "Table", bundle: nil).instantiateViewController(withIdentifier: "TableViewController") as? TableViewController
        
        let TableNC = UINavigationController(rootViewController: TableVC!)
        TableNC.configureVisualNavBar()
        self.tabController?.configureNavigation(viewControllers: [TableNC,MapNC], icons: [UIImage(named: "list")!,UIImage(named: "Map")!], names: ["List","Map"])
        self.window?.rootViewController = self.tabController!
        self.window?.makeKeyAndVisible()
        
    }
    
}

extension UINavigationController{
    func configureVisualNavBar(){
        self.navigationBar.barTintColor = Theme.mainColor
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
            self.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        } else {
            // Fallback on earlier versions
        }
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

extension UIViewController{
    
    func showErrorAlert(error: Error, okCompletion: ((UIAlertAction)->Void)?){
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: okCompletion)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
