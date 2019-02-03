//
//  ReusableView.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell<Cell: UITableViewCell>(_ cellType: Cell.Type) {
        let identifier = String(describing: cellType)
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
}
