//
//  FilterViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/28/21.
//

import UIKit

class FilterViewController: BaseViewController {
    
    var presenter: FilterPresenterProtocol!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dietaryCollectionView: UICollectionView!
    @IBOutlet weak var dietaryCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var priceFilterCollectionView: UICollectionView!
    
    private var categoriesModels = [FiltersModel]() {
        didSet {
            updateCategoriesHeight()
            categoriesCollectionView.reloadData()
        }
    }
    
    private var dietaryModels = [FiltersModel]() {
        didSet {
            updateDietaryHeight()
            dietaryCollectionView.reloadData()
        }
    }
    
    private var priceModels = [PriceFilter]() {
        didSet {
            priceFilterCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let categoriesLayout = LeftAlignedCollectionViewFlowLayout()
        categoriesLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        categoriesCollectionView.collectionViewLayout = categoriesLayout
        categoriesCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        
        let dietaryLayout = LeftAlignedCollectionViewFlowLayout()
        dietaryLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        dietaryCollectionView.collectionViewLayout = dietaryLayout 
        dietaryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        dietaryCollectionView.dataSource = self
        dietaryCollectionView.delegate = self
        
        priceFilterCollectionView.dataSource = self
        priceFilterCollectionView.delegate = self
    }
    
    private func updateCategoriesHeight() {
        var totalItemsWidth: CGFloat = 0
        for item in categoriesModels {
            totalItemsWidth += item.name.width(height: 40, font: UIFont.systemFont(ofSize: 15, weight: .regular)) + 50 + 30
        }
        let numberOfRows = totalItemsWidth / (UIScreen.main.bounds.width - 40)
        let roundValue = numberOfRows.rounded(.up)
        let height = roundValue * 55
        categoriesCollectionViewHeight.constant = height
    }
    
    private func updateDietaryHeight() {
        var totalItemsWidth: CGFloat = 0
        for item in dietaryModels {
            totalItemsWidth += item.name.width(height: 40, font: UIFont.systemFont(ofSize: 15, weight: .regular)) + 50 + 30
        }
        let numberOfRows = totalItemsWidth / (UIScreen.main.bounds.width - 40)
        let roundValue = numberOfRows.rounded(.up)
        let height = roundValue * 55
        dietaryCollectionViewHeight.constant = height
    }
    
    @IBAction func clearAllTapped(_ sender: Any) {
        for index in 0..<categoriesModels.count {
            categoriesModels[index].isSelected = false
        }
        presenter.clearAllCategoriesFilters()
    }
    
    @IBAction func clearAllDietaryTapped(_ sender: Any) {
        for index in 0..<dietaryModels.count {
            dietaryModels[index].isSelected = false
        }
        presenter.clearAllDietaryFilters()
    }
}

extension FilterViewController: FilterViewInput {
    func setupFilters(categories: [FiltersModel], dietary: [FiltersModel]) {
        categoriesModels = categories
        dietaryModels = dietary
    }
}

extension FilterViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == priceFilterCollectionView {
            return priceModels.count
        } else {
            return collectionView == categoriesCollectionView ? categoriesModels.count : dietaryModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == priceFilterCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceFilter", for: indexPath) as! PriceCollectionViewCell
            cell.configureCell(with: priceModels[indexPath.item])
            cell.delegate = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! CategoryCollectionViewCell
            let model = collectionView == categoriesCollectionView ? categoriesModels[indexPath.item] : dietaryModels[indexPath.item]
            cell.configureCell(with: model)
            cell.delegate = self
            return cell
        }
    }
}

extension FilterViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == priceFilterCollectionView {
            return CGSize(width: 60, height: 60)
        } else {
            let models = collectionView == categoriesCollectionView ? categoriesModels : dietaryModels
            let textWidth = models[indexPath.item].name.width(height: 40, font: UIFont.systemFont(ofSize: 15, weight: .regular))
            return CGSize(width: textWidth + 50, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == priceFilterCollectionView ? 20 : 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == priceFilterCollectionView ? 0 : 15
    }
}


extension FilterViewController: CategoryCollectionViewCellDelegate, PriceCollectionViewCellDelegate {
    
    func updateFilter(filter: FiltersModel) {
        presenter.updateFilter(filter: filter)
    }
}
