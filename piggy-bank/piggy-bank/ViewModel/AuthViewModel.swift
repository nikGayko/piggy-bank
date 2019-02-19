//
//  AuthViewModel.swift
//  piggy-bank
//
//  Created by Никита Гайко on 19/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
import ReactiveKit

class AuthViewModel: BaseViewModel {
    
    var authManager: LocalAuthService!
    
    override func initialize() {
        super.initialize()
        
    }
    
    func requestAuth() {
        authManager.requestPin()
            .observeOn(.main)
            .observe { [weak self] (event) in
                switch event {
                case .failed(let error):
                    self?.screenRouter.showError(error as NSError)
                case .next(let success):
                    if success {
                        self?.screenRouter.openBillList()
                    }
                case .completed:
                    break
                }
            }.dispose(in: disposeBag)
    }
}
