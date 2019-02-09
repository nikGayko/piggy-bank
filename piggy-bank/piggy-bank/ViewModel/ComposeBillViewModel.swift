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
import CoreData

class ComposeBillViewModel: BaseViewModel, GroupCellBindingProtocol {
    
    let availableCurrencies = MutableObservableArray<Currency>()
    let isCurrencyContinueEnabled = Observable<Bool>(false)
    let isAmountCompleteEnabled = Observable<Bool>(false)
    let selectedGroup = Observable<Group?>(nil)
    
    let pickCurrency = PublishSubject<Void, NoError>()
    let selectCurrency = PublishSubject<IndexPath, NoError>()
    let inputAmount = PublishSubject<Void, NoError>()
    let assignGroup = PublishSubject<Void, NoError>()
    let completeComposing = PublishSubject<Void, NoError>()
    
    let title = Observable<String?>(nil)
    let currency = Observable<Currency?>(nil)
    let amount = Observable<Double?>(nil)
    
    lazy var groupFetchResultController: NSFetchedResultsController<Group> = {
        let request: NSFetchRequest<Group> = Group.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: false)]
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: coreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    
    override func initialize() {
        super.initialize()
        
        do {
            try groupFetchResultController.performFetch()
        } catch {
            debugPrint("Error while fetching data")
        }
        
        fetchCurrencies()
        
        pickCurrency.observeNext { [weak self] in
            self?.screenRouter.nextPage()
        }.dispose(in: disposeBag)
        
        //Currency
        combineLatest(selectCurrency, availableCurrencies).map { (indexPath, dataSource) in
            return dataSource.collection[indexPath.row]
        }.bind(to: currency)
        
        currency.map { $0 != nil }.bind(to: isCurrencyContinueEnabled).dispose(in: disposeBag)
        
        inputAmount.observeNext { [weak self] in
            self?.screenRouter.nextPage()
        }.dispose(in: disposeBag)
        
        //Amount
        assignGroup.observeNext { [weak self] in
            if self?.groupFetchResultController.fetchedObjects?.isEmpty == true {
                self?.completeComposing.next()
            } else {
                self?.screenRouter.nextPage()
            }
        }.dispose(in: disposeBag)
        
        completeComposing.observeNext { [weak self] in
            if self?.composeBill() == true {
                self?.screenRouter.closeTop()
            }
        }.dispose(in: disposeBag)
        
        amount.map { $0 != nil }.bind(to: isAmountCompleteEnabled).dispose(in: disposeBag)
    }
    
    private func composeBill() -> Bool {
        guard
            let title = title.value,
            let currency = currency.value,
            let amount = amount.value else {
                screenRouter.showInfoAlert(title: "Упс", message: "Не все поля были заполнены")
                return false
        }
        
        coreDataManager.addBill(title: title, currency: currency, group: selectedGroup.value, amount: amount)
        return true
    }
    
    private func fetchCurrencies() {
        let currencies = CurrencyType.allCases.map { Currency(type: $0) }
        availableCurrencies.replace(with: currencies)
    }
}
