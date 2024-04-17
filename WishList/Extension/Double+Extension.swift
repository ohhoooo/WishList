//
//  Int+Extension.swift
//  WishList
//
//  Created by 김정호 on 4/17/24.
//

import Foundation

extension Double {
    func formatterStyle(_ numberStyle: NumberFormatter.Style) -> String? {
        let numberFommater: NumberFormatter = NumberFormatter()
        numberFommater.numberStyle = numberStyle
        return numberFommater.string(for: self)
    }
}
