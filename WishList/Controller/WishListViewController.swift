//
//  WishListViewController.swift
//  WishList
//
//  Created by 김정호 on 4/19/24.
//

import UIKit

class WishListViewController: UIViewController {

    // MARK: - properties
    @IBOutlet weak var tableView: UITableView!
    
    private let coreDataManager = CoreDataManager.shared
    private var products: [Product] = []
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configureData()
        configureTableView()
    }
    
    // MARK: - methods
    private func configureData() {
        products = coreDataManager.fetchProducts()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "WishListTableViewCell", bundle: nil), forCellReuseIdentifier: "WishListTableViewCell")
    }
}

extension WishListViewController: UITableViewDelegate {
    
}

extension WishListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell", for: indexPath) as? WishListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.bind(product: products[indexPath.row])
        
        return cell
    }
}
