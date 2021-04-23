//
//  ColorConfig.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 15/04/2021.
//

import SwiftUI
import Foundation
import UIKit

class ColorConfig {
    private let defaultMainColor = UIColor(displayP3Red: 71/255, green: 71/255, blue: 255/255, alpha: 1)
    private let defaultBackColor = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    private let musicListColor = UIColor(displayP3Red: 194/255, green: 194/255, blue: 194/255, alpha: 1)
    private let startColor = UIColor(displayP3Red: 62/255, green: 142/255, blue: 107/255, alpha: 1)
    private let pauseColor = UIColor(displayP3Red: 254/255, green: 47/255, blue: 32/255, alpha: 1)
    private let darkTextColor = UIColor(displayP3Red: 13/255, green: 22/255, blue: 11/255, alpha: 1)
    private let lightTextColor = UIColor(displayP3Red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    
    func getDefaultMainColor() -> UIColor{
        return defaultMainColor
    }
    
    func getDefaultBackColor() -> UIColor{
        return defaultBackColor
    }
    
    func getMusicListColor() -> UIColor {
        return musicListColor
    }
    
    func getStartColor() -> UIColor {
        return startColor
    }
    
    func getPauseColor() -> UIColor {
        return pauseColor
    }
    
    func getdarkTextColor() -> UIColor {
        return darkTextColor
    }
    
    func getLightTextColor() -> UIColor {
        return lightTextColor
    }
}


