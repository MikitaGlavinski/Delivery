//
//  FirstPlaceCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import UIKit
import Kingfisher

class FirstPlaceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        imageView.kf.setImage(with: url, options: [.cacheMemoryOnly])
    }
}
