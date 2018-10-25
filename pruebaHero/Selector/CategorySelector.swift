//
//  CategorySelectorViewController.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/25/18.
//  Copyright © 2018 hero. All rights reserved.
//

import UIKit

protocol CategorySelectorDelegate{
    func CategorySelectorReturnCategoryID(selector: CategorySelector,Id: String)
}

class CategorySelector: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    var delegate: CategorySelectorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.table.dataSource = self
        self.table.delegate = self
    }

    override func viewDidDisappear(_ animated: Bool) {
        if let index = self.table.indexPathForSelectedRow?.row{
            delegate?.CategorySelectorReturnCategoryID(selector: self, Id: CategoriesService.shared.categories[index].id)
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: TABLE DATASOURCE
extension CategorySelector: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoriesService.shared.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategorySelectorCell") as? CategorySelectorCell
        cell?.categoryViewModel = CategorySelectorCellViewModel(category: CategoriesService.shared.categories[indexPath.row])
        cell?.setup()
        return cell!
    }
    
}

//MARK: TABLE DELEGATE
extension CategorySelector: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
