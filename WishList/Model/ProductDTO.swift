//
//  ProductDTO.swift
//  WishList
//
//  Created by 김정호 on 4/16/24.
//

import Foundation

struct ProductDTO: Decodable {
    let id: Int
    let title: String
    let information: String
    let price: Double
    let thumbnail: String
    
    private enum CodingKeys: String, CodingKey {
        case id, price, title, thumbnail
        case information = "description"
    }
}
