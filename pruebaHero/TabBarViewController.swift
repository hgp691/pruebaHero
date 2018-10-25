//
//  TabBarViewController.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/23/18.
//  Copyright © 2018 hero. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("ViewDid load tabbar")
        
        self.tabBar.barTintColor = Theme.mainColor
        self.tabBar.tintColor = .white
        
        if #available(iOS 10.0, *) {
            self.tabBar.unselectedItemTintColor = Theme.secondaryColor
        } else {
            // Fallback on earlier versions
            
        }
    }
    
    func configureNavigation(viewControllers: [UINavigationController],icons: [UIImage], names: [String]){
        self.viewControllers = viewControllers
        for i in 0...(self.viewControllers?.count)! - 1{
            self.viewControllers?[i].tabBarItem = UITabBarItem(title: names[i], image: icons[i], selectedImage: icons[i])
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
