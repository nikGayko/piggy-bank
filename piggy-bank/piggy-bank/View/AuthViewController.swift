//
//  AuthViewController.swift
//  piggy-bank
//
//  Created by Никита Гайко on 19/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Bond

class AuthViewController: UIViewController {
    
    @IBOutlet weak var authButton: InverseHighlitedButton!
    
    var viewModel: AuthViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authButton.reactive.tap.observeNext { [weak self] in
            self?.viewModel.requestAuth()
        }.dispose(in: reactive.bag)
    }
    
}
