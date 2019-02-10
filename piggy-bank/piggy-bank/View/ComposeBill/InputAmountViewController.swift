//
//  InputAmountViewController.swift
//  piggy-bank
//
//  Created by Никита Гайко on 04/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class InputAmountViewController: UIViewController {
    
    @IBOutlet weak var inputAmountTextField: EdgedTextField!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var completeButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeBarButton: UIBarButtonItem!
    
    var viewModel: ComposeBillViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeButton.reactive.tap.observeNext { [weak self] in
            self?.inputAmountTextField.endEditing(true)
            self?.viewModel.assignGroup.next()
        }.dispose(in: reactive.bag)
        
        viewModel.amount.bidirectionalMap(to: { (double) -> String? in
            if let double = double {
                return "\(double)"
            } else {
                return nil
            }
        }) { (string) -> Double? in
            if let string = string {
                return Double(string)
            } else {
                return nil
            }
        }.bidirectionalBind(to: inputAmountTextField.reactive.text).dispose(in: reactive.bag)
        
        NotificationCenter.default.reactive
            .notification(name: UIResponder.keyboardWillShowNotification)
            .map { notificatoin -> CGFloat? in
                let frame = notificatoin.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
                return frame?.cgRectValue.height
            }
            .ignoreNil()
            .observeNext {[weak self] (height) in
                self?.completeButtonBottomConstraint.constant += height
                UIView.animate(withDuration: 0.3, animations: {
                    self?.view.layoutSubviews()
                })
            }
            .dispose(in: reactive.bag)
        
        viewModel.isAmountCompleteEnabled.bind(to: completeButton.reactive.isEnabled).dispose(in: reactive.bag)
        
        closeBarButton.reactive.tap.bind(to: viewModel.close).dispose(in: reactive.bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.inputAmountTextField.becomeFirstResponder()
        }
    }
    
}
