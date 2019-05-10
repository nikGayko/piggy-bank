//
//  BillTableViewCell.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit
import Bond

class BillTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var titleLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var radioButton: RadioButton!
    
    var selectionMode: Bool = false {
        didSet {
            updateState()
        }
    }
    
    var itemSelected: Bool = false {
        didSet {
            debugPrint(itemSelected)
            radioButton.itemSelected = itemSelected
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(bill: Bill) {
        titleLabel.text = bill.title
        amountLabel.text = NumberFormatter.currencyFormatter.string(from: bill.amount)
        
        if let currency = bill.currency,
            let currencyType = CurrencyType(rawValue: currency.lowercased()) {
            
            let currency = Currency(type: currencyType)
            flagImageView.image = currency.flag
            currencyLabel.text = currency.name
        }
    }
    
    private func updateState() {
        titleLeadingConstraint.constant = selectionMode ? 40.0 : 15.0

        if selectionMode {
            radioButton.isHidden = false
        }
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let `self` = self else { return }
            self.radioButton.alpha = self.selectionMode ? 1.0 : 0.0
            self.layoutSubviews()
        }) { [weak self] _ in
            if self?.selectionMode == false {
                self?.radioButton.isHidden = true
            }
        }
    }
}
