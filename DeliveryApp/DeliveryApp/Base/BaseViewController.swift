//
//  BaseViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/21/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showError(error: Error) {
        var alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        if let netError = error as? NetworkError {
            alert = UIAlertController(title: "Ok", message: netError.rawValue, preferredStyle: .alert)
        }
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
