//
//  InputGroupTitleViewController.swift
//  piggy-bank
//
//  Created by Никита Гайко on 09/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class InputGroupTitleViewController: UIViewController {
    
    @IBOutlet weak var groupTextField: EdgedTextField!
    
    var viewModel: GroupViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTextField.reactive.text.bind(to: viewModel.title).dispose(in: reactive.bag)
        groupTextField.reactive.controlEvents(.editingDidEndOnExit)
            .bind(to: viewModel.openSelectBill)
            .dispose(in: reactive.bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTextField.becomeFirstResponder()
    }
}
