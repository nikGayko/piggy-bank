//
//  CurrencyCollectionViewCell.swift
//  piggy-bank
//
//  Created by Никита Гайко on 05/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var flagImageView: RoundedImageView!
    @IBOutlet weak var currencyAlphaCode: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = #colorLiteral(red: 1, green: 0.7882352941, blue: 0.1921568627, alpha: 1)
    }
    
    static func aspectRation() -> CGFloat {
        return 70/95
    }
    
    func configure(_ country: Currency) {
        flagImageView.image = country.flag
        currencyAlphaCode.text = country.code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        flagImageView.image = nil
        currencyAlphaCode.text = nil
    }
}
