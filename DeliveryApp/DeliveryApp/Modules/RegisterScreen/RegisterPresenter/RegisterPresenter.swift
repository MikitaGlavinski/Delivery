//
//  RegisterPresenter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import Foundation
import RxSwift

class RegisterPresenter {
    
    weak var view: RegisterViewInput!
    var interactor: RegisterInteractorInput!
    var router: RegisterRouter!
    
    private let disposeBag = DisposeBag()
    
}

extension RegisterPresenter: RegisterPresenterProtocol {
    
    func signIn() {
        router.routeToSignIn()
    }
    
    func createAccount(email: String, password: String) {
        guard let accountCreator = interactor.createAccount(email: email, password: password) else { return }
        accountCreator
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { token in
                self.interactor.saveToken(token: token)
            }, onFailure: { error in
                self.view.showError(error: error)
            }).disposed(by: disposeBag)
    }
}
