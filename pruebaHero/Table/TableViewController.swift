//
//  TableViewController.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/24/18.
//  Copyright © 2018 hero. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    var venuesViewModel: VenuesViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.venuesViewModel = VenuesViewModel()
        
        self.table.register(UINib(nibName: "VenueCell", bundle: nil), forCellReuseIdentifier: "VenueCell")
        self.table.delegate = self
        self.table.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationLocationError), name: Notification.Name(LocationMessages.LOCATION_UPDATE_AUTH_ERROR.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.firstUpdateLocation(notification:)), name: Notification.Name(LocationMessages.FIRST_LOCATION_UPDATE.rawValue), object: nil)
        
        LocationService.shared.configureLocationService()
        
        self.title = "List"

        self.configureRightButton()
 
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

//MARK: TABLE DATASOURCE
extension TableViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection \((self.venuesViewModel?.venues.count)!)")
        return (self.venuesViewModel?.venues.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! VenueCell
        cell.setup(venueCellViewModel: (venuesViewModel?.venueViewModelForIndexpath(indexPath: indexPath))!)
        return cell
    }
}

//MARK: TABLE DELEGATE
extension TableViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("selected")
    }
    
}

//MARK: LOCATION NOTIFICATIONS
extension TableViewController{
    
    @objc func firstUpdateLocation(notification: Notification){
        print("FIRST Location updated")
        
        self.venuesViewModel?.initialLoad(completion: {[weak self] (error) in
            if error == nil{
                DispatchQueue.main.async {
                    if (self?.venuesViewModel?.venues.count)! > 0{
                        self?.table.reloadData()
                    }
                }
            }
        })
        
    }
}

//MARK: CATEGORY SEARCH
extension TableViewController: CategorySelectorDelegate{
    
    override func rightButtonClicked() {
        self.showSelector()
    }
    
    func showSelector(){
        let selector = UIStoryboard(name: "CategorySelector", bundle: nil).instantiateViewController(withIdentifier: "CategorySelector") as? CategorySelector
        selector?.delegate = self
        self.definesPresentationContext = true
        selector?.modalPresentationStyle = .fullScreen
        self.present(selector!, animated: true, completion: nil)
    }
    
    func CategorySelectorReturnCategoryID(selector: CategorySelector, Id: String) {
        self.venuesViewModel?.searchVenuesByCategoryId(categoryId: Id, completion: {[weak self] (error) in
            if error == nil{
                DispatchQueue.main.async {
                    if (self?.venuesViewModel?.venues.count)! > 0{
                        self?.table.reloadData()
                    }
                }
            }
        })
    }
}

//MARK: LOCATION NOTIFICATIONS
extension UIViewController{
    
    @objc func notificationLocationError(notification: Notification)->Void{
        
        if let error = notification.userInfo as? [String: Error] {
            self.showErrorAlert(error: error["Error"]!) {[weak self] (accion) in
                let alertAction = UIAlertController(title: "Open Settings", message: "Open Settings to configure Location", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            //print("Settings are opened: \(success)")
                        })
                    }
                    
                })
                
                alertAction.addAction(cancel)
                alertAction.addAction(ok)
                self?.present(alertAction, animated: true, completion: nil)
            }
        }
    }
    
}
