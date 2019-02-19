//
//  HighlitedButton.swift
//  piggy-bank
//
//  Created by Никита Гайко on 19/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class InverseHighlitedButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            update()
        }
    }
    
    func update() {
        let normalColor = self.titleColor(for: .highlighted)
        let highlightedColor = self.titleColor(for: .normal)
        
        borderColor = isHighlighted ? normalColor : highlightedColor
        backgroundColor = isHighlighted ? highlightedColor : normalColor
    }
}
