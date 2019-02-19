//
//  UIImageView+Extensions.swift
//  piggy-bank
//
//  Created by Никита Гайко on 19/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

extension UIImageView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColorDidChange()
    }
}
