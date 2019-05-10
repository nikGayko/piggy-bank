//
//  Rate.swift
//  piggy-bank
//
//  Created by Никита Гайко on 09/05/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation

struct Rate: Hashable, Codable {
    var base: CurrencyType
    var currencyTitle: String
    var rate: Double
}
