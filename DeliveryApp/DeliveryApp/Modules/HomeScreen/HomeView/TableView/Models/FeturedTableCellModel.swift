//
//  FeturedTableCellModel.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/24/21.
//

import UIKit

struct FeturedTableCellModel: TableViewCompatible {
    
    var places: [PlaceModel]
    
    var reuseIdentifier: String = "FeaturedPlaces"
    
    func cellForTableView(tableView: UITableView, delegate: HomePresenterProtocol) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! FeaturedPlacesTableViewCell
        cell.configureCell(with: self)
        return cell
    }
}
