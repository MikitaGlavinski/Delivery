//
//  PlaceDetailAssembly.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import UIKit

class PlaceDetailAssembly {
    
    static func assemble() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let view = storyboard.instantiateViewController(withIdentifier: "PlaceDetail") as! PlaceDetailViewController
        let presenter = PlaceDetailPresenter()
        let interactor = PlaceDetailInteractor()
        let router = PlaceDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.view = view
        
        return view
    }
}
