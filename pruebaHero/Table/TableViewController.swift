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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationLocationError), name: Notification.Name(LocationMessages.LOCATION_UPDATE_AUTH_ERROR.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeStatus), name: Notification.Name(LocationMessages.LOCATION_UPDATE_AUTH.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updatedLocation), name: Notification.Name(LocationMessages.LOCATION_UPDATE.rawValue), object: nil)
        
        if LocationService.shared.available == false{
            LocationService.shared.configureLocationService()
        }
        
        self.venuesViewModel = VenuesViewModel()
        
        self.title = "List"

        self.table.register(UINib(nibName: "VenueCell", bundle: nil), forCellReuseIdentifier: "VenueCell")
        self.table.delegate = self
        self.table.dataSource = self
 
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
        print("selected")
    }
    
}

//MARK: LOCATION NOTIFICATIONS

extension TableViewController{
    
    override func changeStatus(notification: Notification) {
        
    }
    
    override func updatedLocation(norification: Notification) {
        
        print("Updated location notification")
        
        self.venuesViewModel?.initialLoad(completion: {[weak self] (error) in
            if error != nil{
                print("Error: \(String(describing: error?.localizedDescription))")
            }else{
                DispatchQueue.main.async {
                    print("count: \(self?.venuesViewModel?.venues.count)")
                    self?.table.reloadData()
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
                            print("Settings are opened: \(success)")
                        })
                    }
                    
                })
                
                alertAction.addAction(cancel)
                alertAction.addAction(ok)
                self?.present(alertAction, animated: true, completion: nil)
            }
        }
    }
    
    @objc func changeStatus(notification: Notification)->Void{
        
    }
    
    @objc func updatedLocation(norification: Notification)->Void{
        
    }
    
}
