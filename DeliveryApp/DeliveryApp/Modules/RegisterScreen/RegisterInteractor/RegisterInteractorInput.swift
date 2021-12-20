//
//  RegisterInteractorInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/20/21.
//

import Foundation
import RxSwift

protocol RegisterInteractorInput {
    func createAccount(email: String, password: String) -> Single<String>?
}
