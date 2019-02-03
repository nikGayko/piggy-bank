//
//  BaseViewModel.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
import ReactiveKit

class BaseViewModel {
    
    weak var networkService: NetworkService!
    weak var screenRouter: ScreenRouter!
    
    let disposeBag = DisposeBag()
    
    func initialize() {
        
    }
    
    deinit {
        disposeBag.dispose()
    }
}
