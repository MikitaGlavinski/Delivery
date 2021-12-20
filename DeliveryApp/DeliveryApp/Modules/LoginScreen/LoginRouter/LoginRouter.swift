//
//  LoginRouter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import Foundation
import UIKit

class LoginRouter {
    
    weak var view: UIViewController!
    
    func routeToRegisterScreen() {
        let registerView = RegisterAssembly.assemble()
        registerView.modalPresentationStyle = .fullScreen
        view.navigationController?.present(registerView, animated: true, completion: nil)
    }
}
