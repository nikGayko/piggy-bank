//
//  BillsListViewModel.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

class BillsListViewModel: BaseViewModel {
    
    let dataSource = MutableObservableArray2D<String, Bill>()
    
    let isSourceEmpty = Observable<Bool>(true)
    
    let createBill = PublishSubject<Void, NoError>()
    
    override func initialize() {
        super.initialize()
        
        createBill.observeNext { [weak self] in
            self?.screenRouter.openComposeBill()
        }.dispose(in: disposeBag)
    }
}
