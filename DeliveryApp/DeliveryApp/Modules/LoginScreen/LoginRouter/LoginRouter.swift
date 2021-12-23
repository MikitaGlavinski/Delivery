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
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .reveal
        view.navigationController?.view.layer.add(transition, forKey: nil)
        view.navigationController?.pushViewController(registerView, animated: true)
    }
    
    func routeToHome() {
        let homeView = HomeAssembly.assemble()
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = .systemGreen
        tabBar.setViewControllers([homeView], animated: true)
        view.navigationController?.setViewControllers([tabBar], animated: true)
    }
}
