//
//  RadioButton.swift
//  piggy-bank
//
//  Created by Никита Гайко on 09/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class RadioButton: UIButton {
    
    @IBInspectable
    var inset: CGFloat = 1.0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectedColor: UIColor = UIColor.lightGray {
        didSet {
            updateState()
        }
    }
    
    var itemSelected: Bool = false {
        didSet {
            updateState()
        }
    }
    
    private var roundSelectedView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(roundSelectedView)
        
        if borderWidth == 0.0 {
            borderWidth = 1.0
        }
        if borderColor == nil {
            borderColor = UIColor.lightGray
        }
        
        updateView()
        updateState()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(gesture:))))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateView()
    }
    
    @objc private func tap(gesture: UITapGestureRecognizer) {
        itemSelected = !itemSelected
    }
    
    
    private func updateView() {
        let minEdge = min(frame.width, frame.height)
        cornerRadius = minEdge / 2
        
        let doubleInset = (inset + borderWidth) * 2
        roundSelectedView.frame = CGRect(
            x: inset + borderWidth,
            y: inset + borderWidth,
            width: minEdge - doubleInset,
            height: minEdge - doubleInset)
        roundSelectedView.cornerRadius = cornerRadius - inset
    }
    
    private func updateState() {
        roundSelectedView.backgroundColor = itemSelected ? selectedColor : UIColor.clear
    }
}
