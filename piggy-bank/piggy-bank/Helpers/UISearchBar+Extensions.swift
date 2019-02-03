//
//  UISearchBar+textField.swift
//  piggy-bank
//
//  Created by Никита Гайко on 04/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    @IBInspectable
    var textColor: UIColor? {
        get { return textField?.textColor }
        set { textField?.textColor = newValue }
    }
    
    var textFont: UIFont? {
        get { return textField?.font }
        set { textField?.font = newValue }
    }
    
    var textField: UITextField? {
        return self.value(forKey: "searchField") as? UITextField
    }
}
