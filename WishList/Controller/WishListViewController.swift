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
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteContextualAction = UIContextualAction(style: .normal, title: nil) { (_, _, success: @escaping (Bool) -> Void) in
            let alert = UIAlertController(title: "정말로 삭제 하시겠습니까?", message: nil, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            let checkAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                if let targetProduct = self?.products[indexPath.row] {
                    self?.coreDataManager.deleteProduct(product: targetProduct) {
                        self?.configureData()
                        self?.tableView.deleteRows(at: [indexPath], with: .fade)
                        success(true)
                    }
                }
            }
            
            alert.addAction(checkAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        }
        
        deleteContextualAction.backgroundColor = .systemRed
        deleteContextualAction.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteContextualAction])
    }
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
