//
//  ThemeManager.swift
//  MedTracker
//
//  Created by Tahmid Hassan on 2024-04-07.
//

import Foundation
import UIKit

struct ThemeManager {
    
    static func applyTheme(){
        let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        if darkModeEnabled {
            ThemeManager.applyDarkMode(darkModeEnabled)
        } else {
            ThemeManager.applyDarkMode(false)
        }
    }
    
    static func applyDarkMode(_ darkModeEnabled: Bool) {
        
        UserDefaults.standard.set(darkModeEnabled, forKey: "darkModeEnabled")
        
        let windowScenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        windowScenes.forEach { windowScene in
            windowScene.windows.forEach { window in
                window.overrideUserInterfaceStyle = darkModeEnabled ? .dark : .light
            }
        }
    }
}

