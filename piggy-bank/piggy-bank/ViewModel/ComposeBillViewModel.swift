//
//  ComposeBillViewModel.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
import ReactiveKit
import Bond

class ComposeBillViewModel: BaseViewModel {
    
    let availableCurrencies = MutableObservableArray<Currency>()
    
    let pickCurrency = PublishSubject<Void, NoError>()
    let inputAmount = PublishSubject<Void, NoError>()
    let completeComposing = PublishSubject<Void, NoError>()
    
    override func initialize() {
        super.initialize()
        
        pickCurrency.observeNext { [weak self] in
            self?.screenRouter.scrollToSelectCurrency()
        }.dispose(in: disposeBag)
        
        inputAmount.observeNext { [weak self] in
            self?.screenRouter.scrollToInputAmount()
        }.dispose(in: disposeBag)
        
        completeComposing.observeNext { [weak self] in
            self?.screenRouter.closeComposeBill()
        }.dispose(in: disposeBag)
    }
}
