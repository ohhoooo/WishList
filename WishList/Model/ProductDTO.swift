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
    let description: String
    let price: Int
    let thumbnail: String
}
