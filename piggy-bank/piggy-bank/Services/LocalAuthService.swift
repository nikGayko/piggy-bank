//
//  LocalAuthService.swift
//  piggy-bank
//
//  Created by Никита Гайко on 11/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
import ReactiveKit
import LocalAuthentication

class LocalAuthService {
    
    func requestPin() -> Signal<Bool, NSError> {
        return Signal { observer in
            let context = LAContext()
            
            var error: NSError?
            let canEvaluate = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
            
            guard canEvaluate else {
                if let error = error {
                    observer.failed(error)
                } else {
                    observer.completed()
                }
                return SimpleDisposable()
            }
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Для использования приложения требуется авторизация") { (result, error) in
                if let error = error {
                    observer.failed(error as NSError)
                } else {
                    observer.completed(with: result)
                }
            }
            return SimpleDisposable()
        }
    }
}
