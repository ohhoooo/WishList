//
//  WishListTableViewCell.swift
//  WishList
//
//  Created by 김정호 on 4/19/24.
//

import UIKit

class WishListTableViewCell: UITableViewCell {

    // MARK: - properties
    @IBOutlet weak var productLabel: UILabel!
    
    // MARK: - life cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(product: Product) {
        productLabel.text = "[\(product.id)] \(product.title ?? "") - \(product.price.formatterStyle(.decimal))$"
    }
}
