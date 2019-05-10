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
    
    func tabViewModel() -> TabViewModel {
        return scoped(TabViewModel(), configure: { instance in
            self.setupPropertiesAndInit(instance)
        })
    }
    
    func billsList() -> BillsListViewModel {
        return scoped(BillsListViewModel(), configure: { (instance) in
            instance.rateService = self.modelAssembly.currencyService()
            self.setupPropertiesAndInit(instance)
        })
    }
    
    func composeBillVC() -> ComposeBillViewModel {
        return scoped(ComposeBillViewModel(), configure: { (instance) in
            self.setupPropertiesAndInit(instance)
        })
    }
    
    func groupVM() -> GroupViewModel {
        return scoped(GroupViewModel(), configure: { (instance) in
            self.setupPropertiesAndInit(instance)
        })
    }
    
    func editBillAmountVM(bill: Bill) -> EditBillAmountViewModel {
        return scoped(EditBillAmountViewModel(bill: bill)) { instance in
            self.setupPropertiesAndInit(instance)
        }
    }
    
    func authViewModel() -> AuthViewModel {
        return scoped(AuthViewModel()) { instance in
            instance.authManager = self.modelAssembly.localAuthService()
            self.setupPropertiesAndInit(instance)
        }
    }
    
    func settingsViewModel() -> SettingsViewModel {
        return scoped(SettingsViewModel()) { instance in
            self.setupPropertiesAndInit(instance)
        }
    }
    
    private func setupPropertiesAndInit(_ viewModel: BaseViewModel) {
        viewModel.networkService = modelAssembly.networkService()
        viewModel.coreDataManager = modelAssembly.coreDataManager()
        viewModel.screenRouter = screenRouter
        viewModel.initialize()
    }
    
}
