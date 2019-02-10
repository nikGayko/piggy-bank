//
//  GroupViewModel.swift
//  piggy-bank
//
//  Created by Никита Гайко on 09/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Bond
import ReactiveKit
import CoreData

class GroupViewModel: BaseViewModel {
    
    let title = Observable<String?>(nil)
    let selectedBills = MutableObservableSet<Bill>([])
    
    let addBill = PublishSubject<IndexPath, NoError>()
    let removeBill = PublishSubject<IndexPath, NoError>()
    let openSelectBill = PublishSubject<Void, NoError>()
    let complete = PublishSubject<Void, NoError>()
    let close = PublishSubject<Void, NoError>()
    
    lazy var fetchedResultController: NSFetchedResultsController<Bill> = {
        let requst: NSFetchRequest<Bill> = Bill.fetchRequest()
        requst.sortDescriptors = [NSSortDescriptor(key: "createDate", ascending: false)]
        return NSFetchedResultsController(fetchRequest: requst, managedObjectContext: coreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    override func initialize() {
        super.initialize()
        
        openSelectBill.observeNext { [weak self] in
            self?.screenRouter.nextPage()
        }.dispose(in: disposeBag)
        
        addBill
            .map { [weak self] in self?.fetchedResultController.object(at: $0) }
            .ignoreNil()
            .observeNext { [weak self] (bill) in
                self?.selectedBills.insert(bill)
        }.dispose(in: disposeBag)
        
        removeBill
            .map { [weak self] in self?.fetchedResultController.object(at: $0) }
            .ignoreNil()
            .observeNext { [weak self] (bill) in
                self?.selectedBills.remove(bill)
        }.dispose(in: disposeBag)

        complete.observeNext { [weak self] in
            guard
                let title = self?.title.value else {
                    self?.screenRouter.showInfoAlert(title: "Ошибка", message: "Упс, не все поля были заполненны верно")
                    return
            }
            
            self?.coreDataManager.createGroup(title: title, bills: self?.selectedBills.collection ?? [] as Set)
            self?.screenRouter.closeTop()
        }.dispose(in: disposeBag)
        
        close.observeNext { [weak self] in
            self?.screenRouter.closeTop()
        }.dispose(in: disposeBag)
    }
    
    func isBillSelected(_ bill: Bill) -> Bool {
        return selectedBills.changeset.collection.contains(bill)
    }
}
