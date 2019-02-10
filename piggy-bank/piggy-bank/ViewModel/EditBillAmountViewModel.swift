//
//  EditBillAmountViewModel.swift
//  piggy-bank
//
//  Created by Никита Гайко on 10/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Bond
import ReactiveKit

class EditBillAmountViewModel: BaseViewModel {
    
    private let bill: Bill
    
    let newAmount = Observable<Double?>(nil)
    let cancelAction = PublishSubject<Void, NoError>()
    let doneActoin = PublishSubject<Void, NoError>()
    let isDoneEnable = Observable<Bool>(true)
    
    init(bill: Bill) {
        self.bill = bill
    }
    
    override func initialize() {
        super.initialize()
        
        newAmount.next(bill.amount)
        
        newAmount.map { $0 != nil }.bind(to: isDoneEnable).dispose(in: disposeBag)
        
        cancelAction.observeNext { [weak self] in
            self?.screenRouter.closeTop()
        }.dispose(in: disposeBag)
        
        doneActoin.observeNext { [weak self] in
            if self?.saveBill() == true {
                self?.screenRouter.closeTop()
            }
        }.dispose(in: disposeBag)
    }
    
    func saveBill() -> Bool {
        guard
            let newAmount = newAmount.value else {
                return false
        }
        
        coreDataManager.udpateAmount(bill: bill, newAmount: newAmount)
        return true
    }
}
