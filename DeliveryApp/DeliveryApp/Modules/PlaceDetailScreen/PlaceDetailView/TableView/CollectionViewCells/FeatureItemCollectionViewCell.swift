//
//  FeatureItemCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/3/22.
//

import UIKit
import Kingfisher

class FeatureItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    
    private var dishesModel: DishesModel! {
        didSet {
            imageView.kf.setImage(with: URL(string: dishesModel.image), placeholder: UIImage(named: "foodPlaceholder"), options: [.cacheMemoryOnly])
            nameLabel.text = dishesModel.name
            foodTypeLabel.text = dishesModel.foodType[0]
            priceLabel.text = ""
            for _ in 0..<dishesModel.priceType {
                priceLabel.text = (priceLabel.text ?? "") + "$"
            }
        }
    }
    
    func configureCell(with model: DishesModel) {
        dishesModel = model
    }
}
