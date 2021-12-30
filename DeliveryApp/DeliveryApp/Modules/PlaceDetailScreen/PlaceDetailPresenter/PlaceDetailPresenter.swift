//
//  PlaceDetailPresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation

class PlaceDetailPresenter {
    weak var view: PlaceDetailViewInput!
    var interactor: PlaceDetailInteractorInput!
    var router: PlaceDetailRouter!
}

extension PlaceDetailPresenter: PlaceDetailPresenterProtocol {
    
}
