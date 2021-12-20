//
//  LoginViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    var presenter: LoginPresenterProtocol!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var eyeImageView: UIImageView!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        createAccountButton.titleLabel?.adjustsFontSizeToFitWidth = true
        createAccountButton.titleLabel?.minimumScaleFactor = 0.5
    }
    
    @IBAction func emailSignIn(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            } completion: { _ in
                print("up")
            }
        }
    }
    
    @IBAction func createNewAccount(_ sender: Any) {
        presenter.createAccount()
    }
    
    @IBAction func loginFacebook(_ sender: Any) {
    }
    
    @IBAction func loginGoogle(_ sender: Any) {
    }
}

extension LoginViewController: LoginViewInput {
    
}
