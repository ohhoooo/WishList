//
//  ViewController.swift
//  WishList
//
//  Created by 김정호 on 4/16/24.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - properties
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productInformationLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var wishListAddButton: UIButton!
    @IBOutlet weak var differentProductShowButton: UIButton!
    @IBOutlet weak var wishListShowButton: UIButton!
    
    private let coreDataManager = CoreDataManager.shared
    private let networkManager = NetworkManager.shared
    private var randomID = Int.random(in: 1...100)
    private var product: ProductDTO?
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureData()
    }
    
    // MARK: - methods
    private func configureUI() {
        [wishListAddButton, differentProductShowButton, wishListShowButton].forEach { button in
            button?.layer.cornerRadius = 8
            button?.clipsToBounds = true
        }
    }
    
    private func configureData() {
        randomID = Int.random(in: 1...100)
        
        networkManager.fetchProduct(id: randomID) { [weak self] result in
            switch result {
            case .success(let product):
                self?.product = product
                
                DispatchQueue.main.async {
                    self?.productTitleLabel.text = product.title
                    self?.productInformationLabel.text = product.information
                    self?.productPriceLabel.text = product.price.formatterStyle(.decimal) + "$"
                    
                    self?.networkManager.fetchUrlImage(url: product.thumbnail) { result in
                        switch result {
                        case .success(let data):
                            DispatchQueue.main.async {
                                self?.productImageView.image = UIImage(data: data)
                            }
                        case .failure(let error):
                            self?.printError(error)
                        }
                    }
                }
            case .failure(let error):
                self?.printError(error)
            }
        }
    }
    
    private func printError(_ error: Error) {
        switch error {
        case NetworkError.urlConversionFailure:
            print("Url 변환 실패")
        case NetworkError.dataFailure:
            print("네트워크 오류")
        case NetworkError.jsonDecodingFailure:
            print("Json Decoding 실패")
        default:
            print(error.localizedDescription)
        }
    }
    
    @IBAction func addToWishList(_ sender: UIButton) {
        if let product, !coreDataManager.contains(productDTO: product) {
            coreDataManager.saveProduct(productDTO: product) { [weak self] in
                self?.showAlert(title: "상품을 성공적으로 담았습니다.")
            }
        } else {
            showAlert(title: "이미 존재하는 상품입니다.")
        }
    }
    
    @IBAction func showDifferentProduct(_ sender: UIButton) {
        configureData()
    }
    
    @IBAction func showWishList(_ sender: UIButton) {
        if coreDataManager.fetchProducts().isEmpty {
            showAlert(title: "위시 리스트가 존재하지 않습니다.")
        } else {
            performSegue(withIdentifier: "toWishListViewController", sender: nil)
        }
    }
    
    private func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}
