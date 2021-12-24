//
//  FirstPlaceTableViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/23/21.
//

import UIKit

class FirstPlaceTableViewCell: UITableViewCell, Configurable {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: CustomPageControl!
    
    private var placeId: String!
    private var images: [String] = [String]() {
        didSet {
            collectionView.reloadData()
        }
    }
    weak var delegate: HomePresenterProtocol!
    
    private func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 20
    }
    
    func configureCell(with model: FirstPlaceTableCellModel) {
        setupUI()
        placeId = model.placeId
        images = model.images
        collectionView.reloadData()
    }
}

extension FirstPlaceTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstPlace", for: indexPath) as! FirstPlaceCollectionViewCell
        cell.configureCell(with: images[indexPath.item])
        return cell
    }
}

extension FirstPlaceTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / collectionView.frame.width
        pageControl.configureView(selectedIndex: Int(index))
    }
}
