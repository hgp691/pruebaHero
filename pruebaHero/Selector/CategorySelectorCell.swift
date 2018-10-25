//
//  CategorySelectorCell.swift
//  pruebaHero
//
//  Created by Horacio Guzman on 10/25/18.
//  Copyright © 2018 hero. All rights reserved.
//

import UIKit

class CategorySelectorCell: UITableViewCell {
    
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var categoryViewModel: CategorySelectorCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(){
        self.selectionStyle = .none
        self.icon.image = categoryViewModel?.image
        self.name.text = categoryViewModel?.name
    }

}
