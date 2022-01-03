//
//  FeaturedItemsTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/3/22.
//

import UIKit

class FeaturedItemsTableViewCell: UITableViewCell, Configurable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dishesModels: [DishesModel]! {
        didSet {
            collectionView.reloadData()
        }
    }
    
    func configureCell(with model: DetailFeaturedItemsCellModel) {
        collectionView.register(UINib(nibName: "FeatureItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeatureItem")
        collectionView.dataSource = self
        collectionView.delegate = self
        dishesModels = model.dishes
    }
}

extension FeaturedItemsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishesModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureItem", for: indexPath) as! FeatureItemCollectionViewCell
        cell.configureCell(with: dishesModels[indexPath.item])
        return cell
    }
}

extension FeaturedItemsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 240)
    }
}
