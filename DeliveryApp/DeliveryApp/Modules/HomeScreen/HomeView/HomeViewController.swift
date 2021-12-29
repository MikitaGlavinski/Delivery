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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "Test")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func filtersTapped(_ sender: Any) {
        presenter.showFilters()
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
