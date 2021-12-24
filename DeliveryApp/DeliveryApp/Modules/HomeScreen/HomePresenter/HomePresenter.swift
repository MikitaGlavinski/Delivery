//
//  HomePresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import Foundation
import RxSwift

class HomePresenter {
    weak var view: HomeViewInput!
    var router: HomeRouter!
    var interactor: HomeInteractorInput!
    
    private let disposeBag = DisposeBag()
    
    private var placeModels: [PlaceModel] = [PlaceModel]()
    
    private func setupTableView() {
        var cellModels = [TableViewCompatible]()
        let place = placeModels[2]
        cellModels.append(FirstPlaceTableCellModel(placeId: place.id, images: place.images))
        cellModels.append(FeturedTableCellModel(places: placeModels))
        cellModels.append(FeturedTableCellModel(places: placeModels))
        view.setupTableView(models: cellModels)
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        view.showLoader()
        guard let placesGetter = interactor.getPlaces() else { return }
        placesGetter
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] places in
                self?.view.hideLoader()
                self?.placeModels = places
                self?.setupTableView()
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
}
