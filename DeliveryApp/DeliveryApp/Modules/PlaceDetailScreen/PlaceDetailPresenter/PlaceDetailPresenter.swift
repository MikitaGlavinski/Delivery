//
//  PlaceDetailPresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import Foundation
import RxSwift

class PlaceDetailPresenter {
    weak var view: PlaceDetailViewInput!
    var interactor: PlaceDetailInteractorInput!
    var router: PlaceDetailRouter!
    
    private let disposeBag = DisposeBag()
    
    var placeId: String
    
    init(placeId: String) {
        self.placeId = placeId
    }
    
    private func setupCellModels(place: PlaceModel, dishes: [DishesModel]) {
        var cellModels = [TableViewCompatible]()
        cellModels.append(DetailTitleTableCellModel(title: place.name, priceRange: place.price, foodType: place.foodType, rating: place.rating, deliveryTime: place.deliveryTime))
        cellModels.append(DetailFeaturedItemsCellModel(dishes: dishes))
        view.setupTableView(models: cellModels)
    }
}

extension PlaceDetailPresenter: PlaceDetailPresenterProtocol {
    
    func viewDidLoad() {
        view.showLoader()
        var placeModel: PlaceModel!
        guard
            let placeObtainer = interactor.getPlace(placeId: placeId),
            let dishesObtainer = interactor.getDishes(placeId: placeId)
        else { return }
        placeObtainer
            .flatMap({ place -> Single<[DishesModel]> in
                placeModel = place
                return dishesObtainer
            })
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] dishes in
                self?.view.hideLoader()
                self?.setupCellModels(place: placeModel, dishes: dishes)
            }, onFailure: { [weak self] error in
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
}
