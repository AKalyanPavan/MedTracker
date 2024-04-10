//
//  SettingsUIView.swift
//  MedTracker
//
//  Created by Tahmid Hassan on 2024-04-07.
//

import SwiftUI

enum SupportedLanguage: String {
    case english = "english"
    case french = "french"
}

struct SettingsView: View {
    @State private var darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
    @State var languageSetting = LanguageSetting()
    @State private var selectedLanguage = SupportedLanguage.english
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(LocalizedStringKey("Theme"))) {
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                        .onChange(of: darkModeEnabled) { newValue in
                            ThemeManager.applyDarkMode(newValue)
                        }
                }
                Section(header: Text(LocalizedStringKey("Choose Your Preferred Language"))) {
                    Picker("Language", selection: $selectedLanguage) {
                        Text("English").tag(SupportedLanguage.english)
                        Text("French").tag(SupportedLanguage.french)
                    }
                }
                .onChange(of: selectedLanguage) { newValue in
                    print("Selected language changed to:", newValue)
                    languageSetting.setLocale(language: newValue)
                }
                .onAppear {
                    if languageSetting.locale.identifier.contains("fr") {
                        print("OnAppear Device language is French.")
                        selectedLanguage = .french
                    } else {
                        print("OnAppear  Device language is English.")
                        selectedLanguage = .english
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
