//
//  Bill+CoreDataProperties.swift
//  
//
//  Created by Никита Гайко on 19/02/2019.
//
//

import Foundation
import CoreData


extension Bill {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bill> {
        return NSFetchRequest<Bill>(entityName: "Bill")
    }

    @NSManaged public var createDate: NSDate?
    @NSManaged public var currency: String?
    @NSManaged public var title: String?
    @NSManaged public var billNotes: NSSet?
    @NSManaged public var group: Group?

    @objc public var groupTitle: String? {
        return group?.title
    }
    
    @objc public var amount: Double {
        let lastBillNote = self.billNotes?.sortedArray(using: [BillNote.dateSortDescriptor]).last as? BillNote
        return lastBillNote?.amount ?? 0.0
    }
}

// MARK: Generated accessors for billNotes
extension Bill {

    @objc(addBillNotesObject:)
    @NSManaged public func addToBillNotes(_ value: BillNote)

    @objc(removeBillNotesObject:)
    @NSManaged public func removeFromBillNotes(_ value: BillNote)

    @objc(addBillNotes:)
    @NSManaged public func addToBillNotes(_ values: NSSet)

    @objc(removeBillNotes:)
    @NSManaged public func removeFromBillNotes(_ values: NSSet)

}
