//
//  CellProtocols.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import UIKit

protocol Configurable {
    associatedtype T
    func configureCell(with model: T)
}

protocol TableViewCompatible {
    var reuseIdentifier: String { get }
    func cellForTableView(tableView: UITableView, delegate: MainTableViewDelegate?) -> UITableViewCell
}
