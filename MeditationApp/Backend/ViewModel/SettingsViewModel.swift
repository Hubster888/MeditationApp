//
//  SettingsViewModel.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 15/04/2021.
//

import Foundation

class SettingsViewModel : ObservableObject{
    @Published var settings : Settings
    let defaults = UserDefaults.standard
    
    init(){
        let currentModeIndex = defaults.integer(forKey: "displayMode")
        var currentMode = Settings.DisplayMode.adaptive
        switch(currentModeIndex){
        case 0:
            currentMode = .adaptive
        case 1:
            currentMode = .dark
        case 2:
            currentMode = .light
        default:
            currentMode = .adaptive
        }
        self.settings = Settings(displayMode: currentMode, hasPremium: false)
    }
    
    func updateDisplayMode(newIndex: Int){
        print(newIndex)
    }
    
}
