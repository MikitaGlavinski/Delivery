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
    
    private func filterPlaceModels(with selectedFilters: [FiltersModel]) {
        if selectedFilters.count == 0 {
            return
        }
        placeModels = placeModels.filter({ placeModel in
            for filter in selectedFilters {
                if placeModel.foodType.contains(filter.name) {
                    return true
                }
            }
            return false
        })
    }
    
    private func setupTableView() {
        var cellModels = [TableViewCompatible]()
        guard let place = placeModels.first else { return }
        cellModels.append(FirstPlaceTableCellModel(placeId: place.id, images: place.images))
        cellModels.append(FeturedTableCellModel(name: "Featured Partners", places: placeModels))
        cellModels.append(InfoCellModel())
        cellModels.append(FeturedTableCellModel(name: "Best Pick", places: placeModels))
        cellModels.append(TitleCellModel(title: "All Restaurants"))
        for onePlace in placeModels {
            cellModels.append(RestaurantCellModel(place: onePlace))
        }
        view.setupTableView(models: cellModels)
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        view.showLoader()
        guard let placesGetter = interactor.getPlaces() else { return }
        placesGetter
            .flatMap { [weak self] places -> Single<[FiltersModel]> in
                self?.placeModels = places
                guard let filtersObtainer = self?.interactor.getFilters() else {
                    return Single<[FiltersModel]>.error(NetworkError.uncategorized)
                }
                return filtersObtainer
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] filters in
                let selectedFilters = filters.filter({$0.isSelected})
                self?.filterPlaceModels(with: selectedFilters)
                self?.view.hideLoader()
                self?.setupTableView()
            }, onFailure: { [weak self] error in
                self?.view.hideLoader()
                self?.view.showError(error: error)
            }).disposed(by: disposeBag)
        
//        placesGetter
//            .observe(on: MainScheduler.instance)
//            .subscribe(onSuccess: { [weak self] places in
//                self?.view.hideLoader()
//                self?.placeModels = places
//                self?.setupTableView()
//            }, onFailure: { [weak self] error in
//                self?.view.hideLoader()
//                self?.view.showError(error: error)
//            }).disposed(by: disposeBag)
    }
    
    func showFilters() {
        router.showFilters()
    }
}

extension HomePresenter: MainTableViewDelegate {
    
}
