//
//  ModelAssembly.swift
//  piggy-bank
//
//  Created by Никита Гайко on 03/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import Foundation
import FieryCrucible

class ModelAssembly: DependencyFactory {
    
    func networkService() -> NetworkService {
        return shared(NetworkService())
    }
    
    
    
}
