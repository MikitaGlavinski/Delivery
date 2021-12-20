//
//  RegisterAssembly.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit

class RegisterAssembly {
    
    static func assemble() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let view = storyboard.instantiateViewController(withIdentifier: "Register") as! RegisterViewController
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor()
        let router = RegisterRouter()
        
        let authService: AuthorizationService! = ServiceLocator.shared.getService()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.authService = authService
        router.view = view
        
        return view
    }
}
