//
//  UIStoryboard+instantiateVC.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiateVC<T: UIViewController>() -> T? {
        let id = String(describing: T.self)
        return self.instantiateViewController(withIdentifier: id) as? T
    }
}
