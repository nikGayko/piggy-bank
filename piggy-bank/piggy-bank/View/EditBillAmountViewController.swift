//
//  EditBillAmount.swift
//  piggy-bank
//
//  Created by Никита Гайко on 10/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class EditBillAmountViewController: UIViewController {
    
    var viewModel: EditBillAmountViewModel!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    private var cancelAction: UIBarButtonItem?
    private var doneAction: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.newAmount.bidirectionalMap(to: { (value) -> String? in
            if let value = value {
                return String(value)
            } else {
                return nil
            }
        }) { (string) -> Double? in
            if let string = string {
                return Double(string)
            } else {
                return nil
            }
        }.bidirectionalBind(to: amountTextField.reactive.text).dispose(in: reactive.bag)
        
        configureToolbar()
        
        cancelAction?.reactive.tap.doOn(next: { [weak self] () in
            self?.view.endEditing(true)
        }).bind(to: viewModel.cancelAction).dispose(in: reactive.bag)
        doneAction?.reactive.tap.doOn(next: { [weak self] () in
            self?.view.endEditing(true)
        }).bind(to: viewModel.doneActoin).dispose(in: reactive.bag)
        
        if let doneAction = doneAction {
            viewModel.isDoneEnable.bind(to: doneAction.reactive.isEnabled).dispose(in: reactive.bag)
        }
    }
    
    private func configureToolbar() {
        let toolbar = UIToolbar()
        toolbar.barStyle = .black
        
        cancelAction = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        doneAction = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        
        cancelAction?.tintColor = #colorLiteral(red: 1, green: 0.7882352941, blue: 0.1921568627, alpha: 1)
        doneAction?.tintColor = #colorLiteral(red: 1, green: 0.7882352941, blue: 0.1921568627, alpha: 1)
        
        toolbar.items = [cancelAction!, space, doneAction!]
        toolbar.sizeToFit()
        
        amountTextField.inputAccessoryView = toolbar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        amountTextField.becomeFirstResponder()
        amountTextField.selectAll(nil)
    }
    
}
