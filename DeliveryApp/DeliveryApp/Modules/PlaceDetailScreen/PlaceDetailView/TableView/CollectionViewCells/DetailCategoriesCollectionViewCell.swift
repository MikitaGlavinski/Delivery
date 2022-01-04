//
//  DetailCategoriesCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/4/22.
//

import UIKit
import RxSwift
import RxCocoa

protocol MainCollectionViewDelegate: AnyObject {
    func selectCategory(category: String, index: Int)
}

class DetailCategoriesCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: MainCollectionViewDelegate!
    private let disposeBag = DisposeBag()
    private var index: Int = 0
    private var category: String = "" {
        didSet {
            label.text = category
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    func configureCell(with category: String, isSelected: Bool, index: Int) {
        setupUI()
        self.index = index
        label.textColor = isSelected ? .black : .lightGray
        self.category = category
    }
    
    private func setupUI() {
        let tap = UITapGestureRecognizer()
        tap.rx.event.bind { [weak self] _ in
            self?.delegate.selectCategory(category: self!.category, index: self!.index)
        }.disposed(by: disposeBag)
        contentView.addGestureRecognizer(tap)
    }
}
