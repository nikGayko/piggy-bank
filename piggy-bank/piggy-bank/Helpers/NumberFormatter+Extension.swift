//
//  NumberFormatter+Extension.swift
//  piggy-bank
//
//  Created by Никита Гайко on 10/05/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
extension NumberFormatter {
    static var currencyFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = ""
        return numberFormatter
    }
    
    func string(from double: Double) -> String? {
        return string(from: NSNumber(value: double))
    }
}
