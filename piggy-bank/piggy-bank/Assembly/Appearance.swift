//
//  AppearanceAssembly.swift
//  piggy-bank
//
//  Created by Никита Гайко on 07/02/2019.
//  Copyright © 2019 Nikita Gayko. All rights reserved.
//

import UIKit
class Appearance {
    
    class Color {
        static let mainTheme = #colorLiteral(red: 1, green: 0.7882352941, blue: 0.1921568627, alpha: 1)
    }
    
    static func configureAppearance() {
        UINavigationBar.appearance().barTintColor = Color.mainTheme
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}
