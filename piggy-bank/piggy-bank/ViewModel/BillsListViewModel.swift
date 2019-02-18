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

class BillsListViewModel: BaseViewModel {
        
    let isSourceEmpty = Observable<Bool>(false)
    let mainTitle = Observable<String?>(nil)
    
    let createBill = PublishSubject<Void, NoError>()
    let createGroup = PublishSubject<Void, NoError>()
    let editBill = PublishSubject<IndexPath, NoError>()
    
    lazy var fetchResultController: NSFetchedResultsController<Bill> = {
        let request: NSFetchRequest<Bill> = Bill.fetchRequest()
        let sortDescriptors = [
            NSSortDescriptor(key: "group", ascending: false),
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
        
        updateValues()
    }
    
    func sectionTitle(_ section: Int) -> String? {
        return fetchResultController.sections?[section].name
    }
    
    func remove(at indexPath: IndexPath) {
        let obj = fetchResultController.object(at: indexPath)
        coreDataManager.deleteObject(obj)
    }
    
    private func updateValues() {
        isSourceEmpty.next(fetchResultController.fetchedObjects?.count == 0)
    }
}
