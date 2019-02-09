//
//  BillNote+Extensions.swift
//  piggy-bank
//
//  Created by Никита Гайко on 09/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
extension BillNote {
    static var dateSortDescriptor: NSSortDescriptor {
        return NSSortDescriptor(key: "date", ascending: true)
    }
}
