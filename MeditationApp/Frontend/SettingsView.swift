//
//  SettingsView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 30/03/2021.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings : SettingsViewModel
    @EnvironmentObject var currentUser : CurrentUserViewModel
    @State private var displayIndex = 0
    var displayOptions = ["Adaptive", "Light", "Dark"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("MEDITATION")){
                    Picker(selection: $displayIndex, label: Text("Display Mode")) {
                        ForEach(0 ..< displayOptions.count) {
                            Text(self.displayOptions[$0])
                        }
                    }.disabled(true)
                    Button(action: {
                        currentUser.resetStats()
                    }){
                        Text("Reset Stats")
                    }
                }
                Section(header: Text("ACCOUNT")){
                    Button(action: {
                        
                    }){
                        Text("Sign In")
                    }.disabled(true)
                    Button(action: {
                        
                    }){
                        Text("Get Premium")
                    }.disabled(true)
                }
            }
            .navigationBarTitle(Text("Settings"))
        }
    }
}
