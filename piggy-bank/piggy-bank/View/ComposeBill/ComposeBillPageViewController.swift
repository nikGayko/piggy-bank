//
//  ComposeBillPageViewController.swift
//  piggy-bank
//
//  Created by Никита Гайко on 04/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit

class PageContainerViewController: UIPageViewController {
    
    var controllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstVC = controllers.first {
            setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
    }
    
    func openNext() {
        guard let index = currentIndex() else { return }
        
        if index < controllers.count - 1 {
            setViewControllers([controllers[index + 1]], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func openPrevious() {
        guard let index = currentIndex() else { return }
        
        if index > 0 {
            setViewControllers([controllers[index - 1]], direction: .reverse, animated: true, completion: nil)
        }
    }
    
    private func currentIndex() -> Int? {
        guard
            let selectedVC = viewControllers?.first,
            let index = controllers.lastIndex(of: selectedVC) else {
                return nil
        }
        
        return index
    }
}
