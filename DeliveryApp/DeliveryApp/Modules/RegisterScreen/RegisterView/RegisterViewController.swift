//
//  RegisterViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var presenter: RegisterPresenterProtocol!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var confirmPasswordImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func emailSignUp(_ sender: Any) {
    }
    
    @IBAction func signIn(_ sender: Any) {
        presenter.signIn()
    }
    
    @IBAction func facebookSignUp(_ sender: Any) {
    }
    
    @IBAction func googleSignUp(_ sender: Any) {
    }
}

extension RegisterViewController: RegisterViewInput {
    
}
