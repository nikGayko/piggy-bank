//
//  Currency.swift
//  piggy-bank
//
//  Created by Никита Гайко on 06/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

enum CurrencyType: String, CaseIterable, Codable {
    case usd
    case eur
    case gbp
    case byn
    case cyn
    case rub
    case pln
    case uah
}

struct Currency {
    
    let type: CurrencyType
    
    init(type: CurrencyType) {
        self.type = type
    }
    
    var flag: UIImage? {
        switch type {
        case .usd:
            return UIImage(named: "us")
        case .eur:
            return UIImage(named: "eu")
        case .gbp:
            return UIImage(named: "gb")
        case .byn:
            return UIImage(named: "by")
        case .cyn:
            return UIImage(named: "cn")
        case .rub:
            return UIImage(named: "ru")
        case .pln:
            return UIImage(named: "pl")
        case .uah:
            return UIImage(named: "ua")
        }
    }
    
    var code: String {
        return type.rawValue.uppercased()
    }
    
    var name: String {
        switch type {
        case .usd:
            return "Американский доллар"
        case .eur:
            return "Евро"
        case .gbp:
            return "Британский фунт"
        case .byn:
            return "Беларусский рубль"
        case .cyn:
            return "Китайский юань"
        case .rub:
            return "Российский рубль"
        case .pln:
            return "Польский злотый"
        case .uah:
            return "Украинская гривна"
        }
    }
}
