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
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        [wishListAddButton, differentProductShowButton, wishListShowButton].forEach { button in
            button?.layer.cornerRadius = 8
            button?.clipsToBounds = true
        }
    }
    
    @IBAction func addToWishList(_ sender: UIButton) {
    }
    
    @IBAction func showDifferentProduct(_ sender: UIButton) {
    }
    
    @IBAction func showWishList(_ sender: UIButton) {
    }
}
