//
//  HomeViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var presenter: HomePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController: HomeViewInput {
    
}
