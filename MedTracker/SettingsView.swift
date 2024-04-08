//
//  SettingsUIView.swift
//  MedTracker
//
//  Created by Tahmid Hassan on 2024-04-07.
//

import SwiftUI

struct SettingsView: View {
    @State private var darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
    @State private var selectedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Theme")) {
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                        .onChange(of: darkModeEnabled) { newValue in
                            ThemeManager.applyDarkMode(newValue)
                        }
                }
                Section(header: Text("Choose Your Preferred Language")) {
                    Picker("Language", selection: $selectedLanguage) {
                        Text("English").tag("en")
                        Text("French").tag("fr")
                    }
                    .onChange(of: selectedLanguage) {
                        
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
