//
//  NetworkError.swift
//  WishList
//
//  Created by 김정호 on 4/17/24.
//

import Foundation

enum NetworkError: Error {
    case urlConversionFailure
    case dataFailure
    case jsonDecodingFailure
}
