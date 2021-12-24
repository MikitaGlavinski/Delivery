//
//  HomeInteractor.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import Foundation
import RxSwift

class HomeInteractor {
    var firebaseService: FirebaseServiceProtocol!
}

extension HomeInteractor: HomeInteractorInput {
    
    func getPlaces() -> Single<[PlaceModel]>? {
        firebaseService.getPlaces()
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
}
