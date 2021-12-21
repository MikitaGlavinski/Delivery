//
//  LoginViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: BaseViewController {
    
    var presenter: LoginPresenterProtocol!
    private let disposeBag = DisposeBag()

    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        createAccountButton.titleLabel?.adjustsFontSizeToFitWidth = true
        createAccountButton.titleLabel?.minimumScaleFactor = 0.5
    }
    
    private func setupGestures() {
        let mainTap = UITapGestureRecognizer()
        mainTap.rx.event.bind(onNext: { _ in
            self.view.endEditing(true)
        }).disposed(by: disposeBag)
        view.addGestureRecognizer(mainTap)
    }
    
    private func checkCredentials() {
        var animations = [() -> ()]()
        var hideAnimations = [() -> ()]()
        
        animations.append(emailTextField.textField.text?.isEmpty == true ? addAnimation(textField: emailTextField, label: emailLabel) : addCorrectAnimation(textField: emailTextField, label: emailLabel))
        hideAnimations.append(addHideAnimation(textField: emailTextField, label: emailLabel))
        
        animations.append(passwordTextField.textField.text?.isEmpty == true ? addAnimation(textField: passwordTextField, label: passwordLabel) : addCorrectAnimation(textField: passwordTextField, label: passwordLabel))
        hideAnimations.append(addHideAnimation(textField: passwordTextField, label: passwordLabel))
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut) {
            for animation in animations {
                animation()
            }
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 1) {
                for hideAnimation in hideAnimations {
                    hideAnimation()
                }
            }
        }

    }
    
    private func addAnimation(textField: CustomTextField, label: UILabel) -> (() -> ()) {
        textField.frame.origin.x -= 15
        return {
            textField.frame.origin.x += 15
            label.alpha = 1.0
            textField.subviews.first?.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
    private func addCorrectAnimation(textField: CustomTextField, label: UILabel) -> (() -> ()) {
        {
            textField.subviews.first?.layer.borderColor = UIColor.systemGreen.cgColor
        }
    }
    
    private func addHideAnimation(textField: CustomTextField, label: UILabel) -> (() -> ()) {
        {
            label.alpha = 0.0
            textField.subviews.first?.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @IBAction func emailSignIn(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            } completion: { _ in
                self.checkCredentials()
            }
        }
    }
    
    @IBAction func createNewAccount(_ sender: Any) {
        presenter.createAccount()
    }
    
    @IBAction func facebookLogin(_ sender: UIButton) {
    }
    
    @IBAction func googleLogin(_ sender: UIButton) {
    }
}

extension LoginViewController: LoginViewInput {
    
}
