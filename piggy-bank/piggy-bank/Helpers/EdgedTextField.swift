//
//  BorderedTextField.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class EdgedTextField: UITextField {
    
    @IBInspectable
    var edgeWidth: CGFloat = 1.0
    
    @IBInspectable
    var bottomEdge: Bool = false
    
    @IBInspectable
    var leftEdge: Bool = false
    
    @IBInspectable
    var topEdge: Bool = false
    
    @IBInspectable
    var rightEdge: Bool = false
    
    var edgeColor: CGColor {
        return layer.borderColor ?? UIColor.lightGray.cgColor
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(edgeColor)
        context?.setLineWidth(edgeWidth)
        
        if bottomEdge {
            context?.move(to: CGPoint(x: 0, y: bounds.height))
            context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        }
        
        if leftEdge {
            context?.move(to: CGPoint(x: 0, y: bounds.height))
            context?.addLine(to: CGPoint(x: 0, y: 0))
        }
        
        if topEdge {
            context?.move(to: CGPoint(x: 0, y: 0))
            context?.addLine(to: CGPoint(x: bounds.width, y: 0))
        }
        
        if rightEdge {
            context?.move(to: CGPoint(x: bounds.width, y: 0))
            context?.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        }
        
        context?.strokePath()
    }
}
