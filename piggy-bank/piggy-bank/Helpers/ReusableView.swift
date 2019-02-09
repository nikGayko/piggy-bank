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
    
    func registerView<View: UIView>(_ viewType: View.Type) {
        let identifier = String(describing: View.self)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func dequeueCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let subCell = cell as? Cell {
            return subCell
        } else {
            fatalError("Couldn't cast to custom cell")
        }
    }
    
    func dequeueView<View: UIView>() -> View {
        let identifier = String(describing: View.self)
        let view = self.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        if let subView = view as? View {
            return subView
        } else {
            fatalError("Couldn't cast to custom view")
        }
    }
}

extension UICollectionView {
    func registerCell<Cell: UICollectionViewCell>(_ cellType: Cell.Type) {
        let identifier = String(describing: cellType)
        self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if let subCell = cell as? Cell {
            return subCell
        } else {
            fatalError("Couldn't cast to custom cell")
        }
    }
}
