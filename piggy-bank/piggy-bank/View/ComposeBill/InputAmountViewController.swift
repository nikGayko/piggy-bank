//
//  InputAmountViewController.swift
//  piggy-bank
//
//  Created by Никита Гайко on 04/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class InputAmountViewController: UIViewController {
    
    @IBOutlet weak var inputAmountTextField: EdgedTextField!
    
    var viewModel: ComposeBillViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputAmountTextField.reactive.controlEvents(.editingDidEndOnExit).observeNext { [weak self] in
            self?.viewModel.completeComposing.next()
        }.dispose(in: reactive.bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        inputAmountTextField.becomeFirstResponder()
    }
    
}
