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
    
    lazy var fetchResultController: NSFetchedResultsController<Bill> = {
        let request: NSFetchRequest<Bill> = Bill.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createDate", ascending: false)]
        
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: coreDataManager.context, sectionNameKeyPath: "group", cacheName: nil)
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
        
        updateValues()
    }
    
    func sectionTitle(_ section: Int) -> String? {
        let object = fetchResultController.sections?[section].objects?.first as? Bill
        return object?.group?.title
    }
    
    private func updateValues() {
        isSourceEmpty.next(fetchResultController.fetchedObjects?.count == 0)
    }
}
