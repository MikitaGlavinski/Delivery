//
//  DishDetailViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 1/5/22.
//

import UIKit
import Kingfisher

class DishDetailViewController: BaseViewController {
    
    var presenter: DishDetailPresenterProtocol!
    
    private var height: NSLayoutConstraint?
    private var bottom: NSLayoutConstraint?
    
    private var cellModels = [TableViewCompatible]() {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: "DishDetailTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "DishDetailTitle")
        tableView.register(UINib(nibName: "DishChoiceTableViewCell", bundle: nil), forCellReuseIdentifier: "DishChoice")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension DishDetailViewController: DishDetailViewInput {
    
    func setupTableView(cellModels: [TableViewCompatible], imageURL: String) {
        self.cellModels = cellModels
        guard let imageView = headerView.subviews.first as? UIImageView else { return }
        imageView.kf.setImage(with: URL(string: imageURL), placeholder: UIImage(named: "foodPlaceholder"), options: [.cacheMemoryOnly])
    }
}

extension DishDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellModels[indexPath.row]
        let cell = model.cellForTableView(tableView: tableView, delegate: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}

extension DishDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = cellModels[indexPath.row] as? DishChoiceTableCellModel, indexPath.row > 0 else {
            return
        }
        presenter.selectChoice(with: model.name)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let imageView = headerView.subviews.first as? UIImageView {
            height = imageView.constraints.filter({$0.identifier == "height"}).first
            bottom = imageView.constraints.filter({$0.identifier == "bottom"}).first
        }
        
        let offsetY = -scrollView.contentOffset.y
        height?.constant = max(headerView.bounds.height, headerView.bounds.height + offsetY)
    }
}
