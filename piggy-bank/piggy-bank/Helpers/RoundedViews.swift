//
//  RoundedViews.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
    
    override var clipsToBounds: Bool {
        get { return true }
        set { }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let minEdge = min(bounds.width, bounds.height)
        layer.cornerRadius = minEdge/2
    }
}
