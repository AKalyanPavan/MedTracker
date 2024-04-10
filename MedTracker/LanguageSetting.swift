//
//  LanguageManager.swift
//  MedTracker
//
//  Created by Tahmid Hassan on 2024-04-07.
//

import Foundation

struct LanguageSetting {
    
    static func setLanguage() {
        if UserDefaults.standard.object(forKey: "selectedLanguage") == nil {
            UserDefaults.standard.set("en", forKey: "selectedLanguage")
        }
    }
    
    static func handleLanguageChange(_ language: String) {
        UserDefaults.standard.set(language, forKey: "selectedLanguage")
        
        
    }
}
