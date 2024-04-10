//
//  LanguageManager.swift
//  MedTracker
//
//  Created by Tahmid Hassan on 2024-04-07.
//

import Foundation

@Observable
class LanguageSetting {
    
    enum Constants: String {
        case languageKey = "language-key"
        case appleLanguages = "AppleLanguages"
    }
    
    var locale: Locale = .current {
        didSet {}
    }
    
    init() {
        setupInitialLocale()
    }
    
    private func setupInitialLocale() {
        print("Setting up initial locale...")
        if let language =
            UserDefaults.standard.string(forKey: Constants.languageKey.rawValue), 
            let value = SupportedLanguage(rawValue: language) {
            print("Found saved language:", value.rawValue)
            setLocale(language: value)
        } else {
            print("No saved language, using device language...")
            guard let languages =
                    UserDefaults.standard.array(forKey: Constants.appleLanguages.rawValue), let currentLanguage = languages.first as? String  else {
                print("Unable to retrieve device language.")
                return
            }
            
            if currentLanguage.contains("fr") {
                print("Device language is French.")
                setLocale(language: .french)
            } else {
                print("Device language is English.")
                setLocale(language: .english)
            }
        }
    }
    
    func setLocale(language: SupportedLanguage) {
        print("Setting locale to:", language.rawValue)
        switch language {
        case .english:
            locale = Locale(identifier: "en")
        case .french:
            locale = Locale(identifier: "fr")
        }
        
        UserDefaults.standard.setValue(language.rawValue, forKey: Constants.languageKey.rawValue)
        UserDefaults.standard.synchronize()
    }
}
