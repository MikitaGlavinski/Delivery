//
//  placeDetailViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/30/21.
//

import UIKit

class PlaceDetailViewController: BaseViewController {
    
    var presenter: PlaceDetailPresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var cellModels = [TableViewCompatible]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: "DetailTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTitle")
        tableView.register(UINib(nibName: "FeaturedItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailFeature")
        tableView.dataSource = self
    }
}

extension PlaceDetailViewController: PlaceDetailViewInput {
    
    func setupTableView(models: [TableViewCompatible]) {
        cellModels = models
    }
}

extension PlaceDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellModels[indexPath.row]
        let cell = model.cellForTableView(tableView: tableView, delegate: nil)
        return cell
    }
}
