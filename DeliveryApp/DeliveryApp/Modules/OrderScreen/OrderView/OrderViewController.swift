//
//  OrderViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import UIKit

class OrderViewController: UIViewController {
    
    var presenter: OrderPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension OrderViewController: OrderViewInput {
    
}
