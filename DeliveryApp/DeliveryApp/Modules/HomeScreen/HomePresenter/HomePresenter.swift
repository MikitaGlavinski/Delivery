//
//  HomePresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import Foundation

class HomePresenter {
    weak var view: HomeViewInput!
    var router: HomeRouter!
    var interactor: HomeInteractorInput!
}

extension HomePresenter: HomePresenterProtocol {
    
}
