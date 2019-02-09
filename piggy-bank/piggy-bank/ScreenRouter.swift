//
//  ScreenRouter.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit
import ReactiveKit

class ScreenRouter {
    
    weak var viewModelAssembly: ViewModelAssembly!
    
    private enum Presentation {
        case push
        case modal
        case root(_ window: UIWindow?)
    }
    
    private let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    private let launcStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
    private let groupStoryboard = UIStoryboard(name: "Group", bundle: nil)
    
    private func show(viewController: UIViewController, presentation: Presentation, animated: Bool = true, completion: (()->Void)? = nil) {
        switch presentation {
        case .push:
            topPresentedNavVC()?.pushViewController(viewController, animated: animated)
            completion?()
        case .modal:
            topPresentedVC()?.present(viewController, animated: animated, completion: completion)
        case .root(let window):
            window?.rootViewController = viewController
            completion?()
        }
    }
    
    private func keyWindow() -> UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    private func topPresentedVC(_ base: UIViewController? = nil) -> UIViewController? {
        let mutableBase = base ?? keyWindow()?.rootViewController
        
        if let presented = mutableBase?.presentedViewController {
            return topPresentedVC(presented)
        }
        
        if let navVC = mutableBase as? UINavigationController {
            return topPresentedVC(navVC.topViewController)
        }
        
        return mutableBase
    }
    
    private func topPresentedNavVC() -> UINavigationController? {
        return topPresentedVC() as? UINavigationController
    }
    
    private func embedInNavigation(_ viewController: UIViewController, largeTitle: Bool = true) -> UINavigationController {
        let navVC = UINavigationController(rootViewController: viewController)
        navVC.navigationBar.prefersLargeTitles = largeTitle
        navVC.navigationItem.largeTitleDisplayMode = largeTitle ? .always : .never

        return navVC
    }
}

extension ScreenRouter {
    
    func configureRoot(window: UIWindow?) {
        guard
            let billsVC: BillsListViewController = mainStoryboard.instantiateVC() else {
                return
        }
        
        billsVC.viewModel = viewModelAssembly.billsList()
        
        show(viewController: billsVC, presentation: .root(window))
    }
    
    //MARK - Open currencies
    func openComposeBill() {
        guard
            let composeBillVC: InputBillTitleViewController = mainStoryboard.instantiateVC(),
            let selectCurrencyVC: SelectCurrencyViewController = mainStoryboard.instantiateVC(),
            let inputAmountVC: InputAmountViewController = mainStoryboard.instantiateVC(),
            let selectGroupVC: SelectGroupViewController = mainStoryboard.instantiateVC() else {
            return
        }
        
        let composeBillVM = viewModelAssembly.composeBillVC()
        
        composeBillVC.viewModel = composeBillVM
        selectCurrencyVC.viewModel = composeBillVM
        inputAmountVC.viewModel = composeBillVM
        selectGroupVC.viewModel = composeBillVM
        
        let pageContainerVC = PageContainerViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageContainerVC.controllers = [composeBillVC, selectCurrencyVC, inputAmountVC, selectGroupVC]
        
        show(viewController: pageContainerVC, presentation: .modal)
    }
    
    func composeGroup() {
        guard
            let inputTitleVC: InputGroupTitleViewController = groupStoryboard.instantiateVC(),
            let selectBillVC: SelectBillViewController = groupStoryboard.instantiateVC() else {
                return
        }
        
        let viewModel = viewModelAssembly.groupVM()
        inputTitleVC.viewModel = viewModel
        selectBillVC.viewModel = viewModel
        
        let pageVC = PageContainerViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.controllers = [inputTitleVC, selectBillVC]
        
        topPresentedVC()?.present(pageVC, animated: true, completion: nil)
    }
    
    func closeTop() {
        topPresentedVC()?.dismiss(animated: true, completion: nil)
    }
    
    func nextPage() {
        (topPresentedVC() as? PageContainerViewController)?.openNext()
    }
    
    func previousPage() {
        (topPresentedVC() as? PageContainerViewController)?.openPrevious()
    }
}

extension ScreenRouter {
    func showInfoAlert(title: String, message: String) {
        showAlert(title: title, message: message, actions: [AlertAction(title: "ОК", handler: nil)])
    }
    
    fileprivate func showAlert(title: String?, message: String?, actions: [AlertAction]) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            let action = UIAlertAction(title: action.title, style: action.style, handler: { _ in action.handler?() })
            alertVC.addAction(action)
        }
        
        topPresentedVC()?.present(alertVC, animated: true, completion: nil)
    }
}

fileprivate struct AlertAction {
    let title: String
    let handler: (()->())?
    let style: UIAlertAction.Style = .default
}
