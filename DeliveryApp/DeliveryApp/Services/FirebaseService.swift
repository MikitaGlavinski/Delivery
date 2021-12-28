//
//  FirebaseService.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import Foundation
import Firebase
import RxSwift

protocol FirebaseServiceProtocol {
    func getPlaces() -> Single<[PlaceModel]>
}

class FirebaseService: FirebaseServiceProtocol {
    
    private let db = Firestore.firestore()
    
    private func getData<T: Decodable>(path: String, decodeType: T.Type) -> Single<T> {
        Single<T>.create { [weak self] observer -> Disposable in
            self?.db.document(path).getDocument { snapshot, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                guard
                    let document = snapshot,
                    let data = document.data()
                else {
                    observer(.failure(NetworkError.noData))
                    return
                }
                do {
                    let model = try DictionaryDecoder().decode(data, decodeType: decodeType)
                    observer(.success(model))
                } catch let error {
                    observer(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    private func getListData<T: Decodable>(path: String, decodeType: T.Type) -> Single<[T]> {
        Single<[T]>.create { [weak self] observer -> Disposable in
            self?.db.collection(path).getDocuments { snapshot, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                guard let snapshot = snapshot else {
                    observer(.failure(NetworkError.noData))
                    return
                }
                do {
                    let decoder = DictionaryDecoder()
                    let models = try snapshot.documents.compactMap({try decoder.decode($0.data(), decodeType: decodeType)})
                    observer(.success(models))
                } catch let error {
                    observer(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func getPlaces() -> Single<[PlaceModel]> {
        getListData(path: "places", decodeType: PlaceModel.self)
    }
}
