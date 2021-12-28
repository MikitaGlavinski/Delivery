//
//  SearchViewController.swift
//  DeliveryApp
//
//  Created by Mikita Glavinski on 12/27/21.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {
    
    var presenter: SearchPresenterProtocol!
    private let disposeBag = DisposeBag()
    
    private var cellModels = [RestaurantCellModel]() {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: CustomSearchBar!
    @IBOutlet weak var backViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
        setupGestures()
    }
    
    private func setupUI() {
        tableView.register(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "Test")
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    private func setupGestures() {
        let mainTap = UITapGestureRecognizer()
        mainTap.rx.event.bind { [weak self] _ in
            self?.view.endEditing(true)
        }.disposed(by: disposeBag)
        view.addGestureRecognizer(mainTap)
    }

}

extension SearchViewController: SearchViewInput {
    
    func setupTableView(places: [RestaurantCellModel]) {
        cellModels = places
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = cellModels[indexPath.row]
        let cell = model.cellForTableView(tableView: tableView, delegate: nil)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Top Restaurants"
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.frame = CGRect(x: 25, y: 18, width: UIScreen.main.bounds.width - 50, height: 30)
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(label)
        view.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 80)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeNumber = min((-scrollView.contentOffset.y * 0.8), 0)
        backViewTopConstraint.constant = changeNumber
        tableViewTopConstraint.constant = max(-changeNumber - 110, 0)
    }
}

extension SearchViewController: CustomSearchBarDelegate {
    
    func textDidChenged(text: String, searchBar: CustomSearchBar) {
        presenter.filterPlaces(with: text)
    }
}
