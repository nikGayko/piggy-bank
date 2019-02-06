//
//  ComposeBillViewController.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class InputBillTitleViewController: UIViewController {
    
    @IBOutlet weak var billTitleTextField: EdgedTextField!
    
    var viewModel: ComposeBillViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billTitleTextField.reactive.controlEvents(.editingDidEndOnExit).observeNext { [weak self] in
            self?.viewModel.pickCurrency.next()
            }.dispose(in: reactive.bag)
        
        viewModel.title.bidirectionalBind(to: billTitleTextField.reactive.text).dispose(in: reactive.bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        billTitleTextField.becomeFirstResponder()
    }
}
