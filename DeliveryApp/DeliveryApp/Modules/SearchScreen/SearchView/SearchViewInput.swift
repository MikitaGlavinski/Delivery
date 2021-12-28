//
//  SearchViewInput.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import Foundation

protocol SearchViewInput: AnyObject {
    func showError(error: Error)
    func showLoader()
    func hideLoader()
    func setupTableView(places: [RestaurantCellModel])
}
