//
//  CoreDataManager.swift
//  piggy-bank
//
//  Created by Никита Гайко on 04/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private lazy var container: NSPersistentContainer = {
        return NSPersistentContainer(name: "PiggyBank")
    }()
    
    init() {
        container.loadPersistentStores { (description, error) in
            debugPrint(description)
        }
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveContext() {
        guard context.hasChanges else {
            return
        }
        do {
            try context.save()
        } catch {
            debugPrint(error)
        }
    }
    
}

extension CoreDataManager {
    func addBill(title: String, currency: Currency, group: Group?, amount: Double) {
        let currentDate = Date()
        
        let bill = Bill(context: context)
        bill.title = title
        bill.currency = currency.code
        bill.createDate = currentDate
        bill.group = group
        
        let billNote = BillNote(context: context)
        billNote.amount = amount
        billNote.date = currentDate
        bill.addToBillNotes(billNote)
        
        bill.addToBillNotes(billNote)
        saveContext()
    }
    
    func createGroup(title: String, bills: Set<Bill>) {
        let group = Group(context: context)
        group.title = title
        group.addToBills(bills as NSSet)
        saveContext()
    }
}
