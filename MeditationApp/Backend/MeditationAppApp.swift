//
//  MeditationAppApp.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 24/03/2021.
//

import SwiftUI

@main
struct MeditationAppApp: App {
    
    @ObservedObject var currentUser : CurrentUserViewModel = CurrentUserViewModel()
    @ObservedObject var settings : SettingsViewModel = SettingsViewModel()
    @ObservedObject var musciViewModel : MusicViewModel = MusicViewModel()
    @ObservedObject var homeViewModel : HomeViewModel = HomeViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    
    var body: some Scene {
        WindowGroup {
            if(launchedBefore){
                ContentView()
                    .environmentObject(self.currentUser)
                    .environmentObject(self.settings)
                    .environmentObject(self.musciViewModel)
                    .environmentObject(self.homeViewModel)
            }else{
                OnboardView()
                    .environmentObject(self.currentUser)
                    .environmentObject(self.settings)
                    .environmentObject(self.musciViewModel)
                    .environmentObject(self.homeViewModel)
            }
        }
    }
}
