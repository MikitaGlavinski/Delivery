//
//  DishChoiceTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import UIKit

class DishChoiceTableViewCell: UITableViewCell, Configurable {
    
    @IBOutlet weak var bigCheckBoxView: UIView!
    @IBOutlet weak var smallCheckBoxView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureCell(with model: DishChoiceTableCellModel) {
        nameLabel.text = model.name
        
        bigCheckBoxView.layer.borderWidth = 1
        bigCheckBoxView.layer.borderColor = model.isSelected ? UIColor(red: 34/255, green: 164/255, blue: 97/255, alpha: 1).cgColor : UIColor.lightGray.cgColor
        smallCheckBoxView.isHidden = model.isSelected ? false : true
    }
}
