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
    
    var authManager: LocalM
    
    let auth = PublishSubject<Void, NoError>()
    
    override func initialize() {
        super.initialize()
        
        auth.observeNext {
            <#code#>
        }
    }
}
