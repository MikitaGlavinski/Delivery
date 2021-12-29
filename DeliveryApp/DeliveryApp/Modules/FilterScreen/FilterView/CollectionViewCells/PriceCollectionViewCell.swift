//
//  PriceCollectionViewCell.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/29/21.
//

import UIKit
import RxCocoa
import RxSwift

protocol PriceCollectionViewCellDelegate: AnyObject {
    
}

class PriceCollectionViewCell: UICollectionViewCell {
    
    private let disposeBag = DisposeBag()
    weak var delegate: PriceCollectionViewCellDelegate!
    
    private var priceModel: PriceFilter! {
        didSet {
            if priceModel.isSelected {
                contentView.backgroundColor = UIColor(red: 34/255, green: 164/255, blue: 93/255, alpha: 1)
                label.textColor = .white
            } else {
                contentView.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
                label.textColor = UIColor(red: 112/255, green: 119/255, blue: 115/255, alpha: 1)
            }
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    func configureCell(with model: PriceFilter) {
        priceModel = model
        
        for _ in 0..<priceModel.value {
            label.text = (label.text ?? "") + "$"
        }
        
        contentView.layer.cornerRadius = 30
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer()
        tap.rx.event.bind { [weak self] _ in
            self?.priceModel.isSelected.toggle()
        }.disposed(by: disposeBag)
        contentView.addGestureRecognizer(tap)
    }
}
