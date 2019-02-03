//
//  RoundedViews.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
    
    override func draw(_ rect: CGRect) {
        let minEdge = min(rect.width, rect.height)
        layer.cornerRadius = minEdge/2
    }
}
