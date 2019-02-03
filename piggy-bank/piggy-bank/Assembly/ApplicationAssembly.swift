//
//  ApplicationAssembly.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation

class ApplicationAssembly {
    
    let modelAssembly: ModelAssembly
    let viewModelAssembly: ViewModelAssembly
    let screenRouter: ScreenRouter
    
    init() {
        modelAssembly = ModelAssembly()
        screenRouter = ScreenRouter()
        viewModelAssembly = ViewModelAssembly(modelAssembly: modelAssembly, screenRouter: screenRouter)
    }
    
}
