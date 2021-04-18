//
//  Settings.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 15/04/2021.
//

import Foundation

struct Settings {
    var displayMode : DisplayMode
    var hasPremium : Bool
    
    enum DisplayMode {
        case dark
        case light
        case adaptive
    }
}
