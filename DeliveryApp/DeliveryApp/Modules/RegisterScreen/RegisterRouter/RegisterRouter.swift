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
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .reveal
        view.navigationController?.view.layer.add(transition, forKey: nil)
        view.navigationController?.popViewController(animated: true)
    }
    
    func routeToHome() {
        let homeView = HomeAssembly.assemble()
        let tabBar = UITabBarController()
        tabBar.setViewControllers([homeView], animated: true)
        view.navigationController?.setViewControllers([tabBar], animated: true)
    }
}
