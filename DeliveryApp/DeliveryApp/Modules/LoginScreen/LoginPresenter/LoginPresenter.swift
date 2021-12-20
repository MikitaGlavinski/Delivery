//
//  LoginPresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import Foundation

class LoginPresenter {
    
    weak var view: LoginViewInput!
    var interactor: LoginInteractorInput!
    var router: LoginRouter!
}

extension LoginPresenter: LoginPresenterProtocol {
    
    func createAccount() {
        router.routeToRegisterScreen()
    }
}
