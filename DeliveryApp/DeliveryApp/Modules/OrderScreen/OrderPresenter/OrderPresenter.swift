//
//  OrderPresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation

class OrderPresenter {
    weak var view: OrderViewInput!
    var interactor: OrderInterctorInput!
    var router: OrderRouter!
}

extension OrderPresenter: OrderPresenterProtocol {
    
}
