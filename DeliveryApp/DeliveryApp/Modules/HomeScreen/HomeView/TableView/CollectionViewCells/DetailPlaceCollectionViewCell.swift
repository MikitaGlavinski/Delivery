//
//  DetailPlaceCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import UIKit
import Kingfisher

class DetailPlaceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deliveryTypeLabel: UILabel!
    
    func configureCell(with model: PlaceModel) {
        imageView.kf.setImage(with: URL(string: model.images[0]), options: [])
        nameLabel.text = model.name
        locationLabel.text = model.location
        ratingLabel.text = String(model.rating)
        timeLabel.text = "\(model.deliveryTime) min"
        deliveryTypeLabel.text = model.deliveryType
    }
}
