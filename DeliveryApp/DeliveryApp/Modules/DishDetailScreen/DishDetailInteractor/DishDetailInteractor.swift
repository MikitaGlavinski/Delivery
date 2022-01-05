//
//  DishDetailInteractor.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import Foundation
import RxSwift

class DishDetailInteractor {
    var firebaseService: FirebaseServiceProtocol!
}

extension DishDetailInteractor: DishDetailInteractorInput {
    
    func obtainDish(dishId: Int, placeId: String) -> Single<DishesModel>? {
        firebaseService.getDish(dishId: dishId, placeId: placeId)
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
    }
}
