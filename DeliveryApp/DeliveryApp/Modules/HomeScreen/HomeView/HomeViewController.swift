//
//  HomeViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/22/21.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var presenter: HomePresenterProtocol!

    @IBOutlet weak var tableView: UITableView!
    
    private var cellModels = [TableViewCompatible]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "Test")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension HomeViewController: HomeViewInput {
    
    func setupTableView(models: [TableViewCompatible]) {
        self.cellModels = models
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellModels[indexPath.row]
        return model.cellForTableView(tableView: tableView, delegate: nil)
    }
}

extension HomeViewController: UITableViewDelegate {

}
