//
//  GroupCell.swift
//  piggy-bank
//
//  Created by Никита Гайко on 09/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit
import Bond

protocol GroupCellBindingProtocol {
    var selectedGroup: Observable<Group?> { get }
}

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var radioButton: RadioButton!
    
    var group: Group? {
        didSet {
            titleLabel.text = group?.title
        }
    }
    
    func configure(viewModel: GroupCellBindingProtocol) {
        viewModel.selectedGroup.observeNext { [weak self] (group) in
            self?.radioButton.itemSelected = group == self?.group
        }.dispose(in: reactive.bag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reactive.bag.dispose()
    }
    
}
