//
//  Bill+Extensions.swift
//  piggy-bank
//
//  Created by Никита Гайко on 10/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
extension Bill {
    var amount: Double? {
        if let lastBillNote = self.billNotes?.sortedArray(using: [BillNote.dateSortDescriptor]).last as? BillNote {
            return lastBillNote.amount
        } else {
            return nil
        }
    }
}
