//
//  BillsListViewModel.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
import CoreData
import Bond
import ReactiveKit
import NotificationBannerSwift

class BillsListViewModel: BaseViewModel {
    
    var rateService: RatesService!
    
    let isSourceEmpty = Observable<Bool>(false)
    let mainTitle = Observable<String?>(nil)
    
    let createBill = PublishSubject<Void, NoError>()
    let createGroup = PublishSubject<Void, NoError>()
    let editBill = PublishSubject<IndexPath, NoError>()
    let openSettings = PublishSubject<Void, NoError>()
    
    let isRatesSyncing = Observable<Bool>(false)
    
    private let baseCurrency = CurrencyType.usd
    
    lazy var fetchResultController: NSFetchedResultsController<Bill> = {
        let request: NSFetchRequest<Bill> = Bill.fetchRequest()
        let sortDescriptors = [
            NSSortDescriptor(key: "group.title", ascending: false),
            NSSortDescriptor(key: "createDate", ascending: false)
        ]
        request.sortDescriptors = sortDescriptors
        
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: coreDataManager.context, sectionNameKeyPath: "groupTitle", cacheName: nil)
    }()
    
    override func initialize() {
        super.initialize()
        
        do {
            try fetchResultController.performFetch()
        } catch {
            debugPrint("Controller fetch error: \(error)")
        }
        
        mainTitle.next("Мои счета")
        
        createBill.observeNext { [weak self] in
            self?.screenRouter.openComposeBill()
        }.dispose(in: disposeBag)
        
        createGroup.observeNext { [weak self] in
            self?.screenRouter.composeGroup()
        }.dispose(in: disposeBag)
        
        NotificationCenter.default.reactive
            .notification(name: NSNotification.Name.NSManagedObjectContextObjectsDidChange)
            .observeNext { [weak self] (_) in
                self?.updateValues()
        }.dispose(in: disposeBag)
        
        editBill
            .map { [weak self] in self?.fetchResultController.object(at: $0)}
            .ignoreNil()
            .observeNext { [weak self] (bill) in
                self?.screenRouter.openEditBill(bill)
        }.dispose(in: disposeBag)
        
        openSettings.observeNext { [weak self] () in
            self?.screenRouter.openSettings()
        }.dispose(in: disposeBag)
        
        rateService.updateRates()
            .take(first: 1)
            .observeOn(.main)
            .doOn(start: { [weak self] in
                self?.isRatesSyncing.next(true)
            }, failed: { [weak self] (error) in
                self?.screenRouter.showCurrencySyncFailedBanner()
                self?.isRatesSyncing.next(false)
            }, completed: { [weak self] in
                self?.screenRouter.showCurrencySyncSuccessedBanner()
                self?.isRatesSyncing.next(false)
            })
            .observeCompleted { }
            .dispose(in: disposeBag)
        
        updateValues()
    }
    
    func sectionTitle(_ section: Int) -> String? {
        return fetchResultController.sections?[section].name
    }
    
    func remove(at indexPath: IndexPath) {
        let obj = fetchResultController.object(at: indexPath)
        coreDataManager.deleteObject(obj)
    }
    
    func amount(section: Int) -> Double {
        let bills = fetchResultController.sections?[section].objects as? [Bill]
        var amount = 0.0
        for bill in bills ?? [] {
            if bill.currency?.lowercased() == baseCurrency.rawValue {
                amount += bill.amount
            } else if let rate = rateService.rate(currency: bill.currency ?? "") {
                amount += bill.amount / rate
            }
        }
        return amount
    }
    
    private func updateValues() {
        isSourceEmpty.next(fetchResultController.fetchedObjects?.count == 0)
    }
}
