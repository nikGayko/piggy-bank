//
//  ViewModelAssembly.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
import FieryCrucible

class ViewModelAssembly: DependencyFactory {
    
    private let modelAssembly: ModelAssembly
    private let screenRouter: ScreenRouter
    
    init(modelAssembly: ModelAssembly, screenRouter: ScreenRouter) {
        self.modelAssembly = modelAssembly
        self.screenRouter = screenRouter
    }
    
    func billsList() -> BillsListViewModel {
        return scoped(BillsListViewModel(), configure: { (instance) in
            self.setupPropertiesAndInit(instance)
        })
    }
    
    func composeBillVC() -> ComposeBillViewModel {
        return scoped(ComposeBillViewModel(), configure: { (instance) in
            self.setupPropertiesAndInit(instance)
        })
    }
    
    private func setupPropertiesAndInit(_ viewModel: BaseViewModel) {
        viewModel.networkService = modelAssembly.networkService()
        viewModel.screenRouter = screenRouter
        viewModel.initialize()
    }
    
}
