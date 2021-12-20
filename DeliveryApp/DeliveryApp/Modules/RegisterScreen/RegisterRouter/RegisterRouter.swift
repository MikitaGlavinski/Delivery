//
//  RegisterRouter.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit

class RegisterRouter {
    
    weak var view: UIViewController!
    
    func routeToSignIn() {
        view.dismiss(animated: true, completion: nil)
    }
}
