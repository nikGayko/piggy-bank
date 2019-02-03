//
//  ScreenRouter.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class ScreenRouter {
    
    private enum Presentation {
        case push
        case modal
        case root
    }
    
    private let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    private let launcStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
    
    private var keyWindow: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    private func show(viewController: UIViewController, presentation: Presentation, animated: Bool = true, completion: (()->Void)? = nil) {
        switch presentation {
        case .push:
            topPresentedNavVC()?.pushViewController(viewController, animated: animated)
            completion?()
        case .modal:
            topPresentedVC()?.present(viewController, animated: animated, completion: completion)
        case .root:
            keyWindow?.rootViewController = viewController
            completion?()
        }
    }
    
    func topPresentedVC() -> UIViewController? {
        return keyWindow?.rootViewController
    }
    
    func topPresentedNavVC() -> UINavigationController? {
        return topPresentedVC() as? UINavigationController
    }
}
