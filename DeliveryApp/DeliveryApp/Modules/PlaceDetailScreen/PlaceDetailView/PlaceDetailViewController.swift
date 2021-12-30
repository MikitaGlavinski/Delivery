//
//  placeDetailViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import UIKit

class PlaceDetailViewController: UIViewController {
    
    var presenter: PlaceDetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PlaceDetailViewController: PlaceDetailViewInput {
    
}
