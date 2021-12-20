//
//  AuthorizationService.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import Foundation
import Firebase
import RxSwift

protocol AuthorizationServiceProtocol {
    func createAccount(email: String, password: String) -> Single<String>
}

class AuthorizationService: AuthorizationServiceProtocol {
    
    func createAccount(email: String, password: String) -> Single<String> {
        Single<String>.create { observer -> Disposable in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                guard let token = authResult?.user.uid else {
                    observer(.failure(NetworkError.noData))
                    return
                }
                observer(.success(token))
            }
            return Disposables.create()
        }
    }
}
