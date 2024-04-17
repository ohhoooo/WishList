//
//  Int+Extension.swift
//  WishList
//
//  Created by 김정호 on 4/17/24.
//

import Foundation

extension Double {
    func formatterStyle(_ numberStyle: NumberFormatter.Style) -> String {
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = numberStyle
        numberFormatter.maximumFractionDigits = 3
        return numberFormatter.string(for: self) ?? "0"
    }
}
