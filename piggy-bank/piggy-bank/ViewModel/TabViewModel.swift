//
//  TabViewModel.swift
//  piggy-bank
//
//  Created by Никита Гайко on 08/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
import ReactiveKit

class TabViewModel: BaseViewModel {
    
    let openCreateBill = PublishSubject<Void, NoError>()
    let openCreateGroup = PublishSubject<Void, NoError>()
    
    override func initialize() {
        super.initialize()
        
        openCreateBill.observeNext { [weak self] in
            self?.screenRouter.openComposeBill()
        }.dispose(in: disposeBag)
    }
    
}
