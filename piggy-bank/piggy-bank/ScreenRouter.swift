//
//  ScreenRouter.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class ScreenRouter {
    
    weak var viewModelAssembly: ViewModelAssembly!
    
    private enum Presentation {
        case push
        case modal
        case root(_ window: UIWindow?)
    }
    
    private let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    private let launcStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
    
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
    
    private func topPresentedVC() -> UIViewController? {
        return keyWindow()?.rootViewController
    }
    
    private func topPresentedNavVC() -> UINavigationController? {
        return topPresentedVC() as? UINavigationController
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
    
    func openComposeBill() {
        guard
            let composeBillVC: ComposeBillViewController = mainStoryboard.instantiateVC() else {
            return
        }
        
        composeBillVC.viewModel = viewModelAssembly.compo
    }
}
