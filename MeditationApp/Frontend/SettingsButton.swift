//
//  SettingsButton.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 29/03/2021.
//

import SwiftUI

struct SettingsButton: View {
    
    var buttonWidth : CGFloat {
        return width * 0.8
    }
    var buttonHeight : CGFloat {
        return height * 0.05
    }
    var textSize : CGFloat {
        return width * 0.05
    }
    let cornerRadius : CGFloat = 20
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    let shadowRadius : CGFloat = 10
    let shadowDimensions : CGFloat = 5
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(ColorConfig().getDefaultBackColor()))
                .frame(width: buttonWidth, height: buttonHeight, alignment: .center)
                .cornerRadius(cornerRadius)
                .shadow(radius: shadowRadius, x: shadowDimensions, y: shadowDimensions)
            Text("Settings")
                .font(.system(size: textSize, design: .monospaced))
                .foregroundColor(Color(ColorConfig().getdarkTextColor()))
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton()
            .previewLayout(.device)
    }
}
