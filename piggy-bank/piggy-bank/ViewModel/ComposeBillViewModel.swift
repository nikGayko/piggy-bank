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
    let selectCurrency = PublishSubject<IndexPath, NoError>()
    let completeComposing = PublishSubject<Void, NoError>()
    
    let title = Observable<String?>(nil)
    let currency = Observable<Currency?>(nil)
    let amount = Observable<Double?>(nil)
    
    override func initialize() {
        super.initialize()
        
        fetchCurrencies()
        
        pickCurrency.observeNext { [weak self] in
            self?.screenRouter.scrollToSelectCurrency()
        }.dispose(in: disposeBag)
        
        combineLatest(selectCurrency, availableCurrencies).map { (indexPath, dataSource) in
            return dataSource.collection[indexPath.row]
        }.bind(to: currency)
        
        selectCurrency.observeNext { [weak self] (indexPath) in
            self?.screenRouter.scrollToInputAmount()
        }.dispose(in: disposeBag)
        
        completeComposing.observeNext { [weak self] in
            self?.composeBill()
            self?.screenRouter.closeComposeBill()
        }.dispose(in: disposeBag)
    }
    
    private func composeBill() {
        guard
            let title = title.value,
            let currency = currency.value,
            let amount = amount.value else {
                screenRouter.showInfoAlert(title: "Упс", message: "Не все поля были заполнены")
                return
        }
        
        coreDataManager.addBill(title: title, currency: currency, amount: amount)
    }
    
    private func fetchCurrencies() {
        let currencies = CurrencyType.allCases.map { Currency(type: $0) }
        availableCurrencies.replace(with: currencies)
    }
}
