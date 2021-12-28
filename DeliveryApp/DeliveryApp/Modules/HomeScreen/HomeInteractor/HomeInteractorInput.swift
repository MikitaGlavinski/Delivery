//
//  HomeInteractorInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import Foundation
import RxSwift

protocol HomeInteractorInput {
    func getPlaces() -> Single<[PlaceModel]>?
}