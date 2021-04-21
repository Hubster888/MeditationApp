//
//  OnboardingStepView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 20/04/2021.
//

import SwiftUI

struct OnboardingStepView: View {
    var data: OnboardingDataModel
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var imageWidth : CGFloat {
        return width * 0.4
    }
    var imageHeight : CGFloat {
        return height * 0.35
    }
    var textHeight : CGFloat {
        if(data.image != nil){
            return height * 0.2
        }else{
            return height * 0.05
        }
    }
    
    var body: some View {
        VStack {
            if(data.image != nil){
                /*Image(uiImage: UIImage(imageLiteralResourceName: data.image!))
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                    .padding(EdgeInsets(top: height * 0.01, leading: 0, bottom: height * 0.025, trailing: 0))*/
                Image(uiImage: UIImage(imageLiteralResourceName: data.image!))
                    .resizable()
                    .scaledToFit()
                    .mask(Circle())
                    .shadow(radius: 15)
                    .overlay(Circle().stroke(Color(ColorConfig().getDefaultBackColor()), lineWidth: 5).shadow(radius: 15))
                    .frame(width: width, height: width, alignment: .center)
                    .padding(EdgeInsets(top: height * 0.01, leading: 0, bottom: height * 0.025, trailing: 0))

            }
            Text(data.heading)
                .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
                .font(.system(size: width * 0.05, design: .rounded))
                .fontWeight(.bold)
                .padding(.bottom, width * 0.025)
                .offset(y: -25)
            
            Text(data.text)
                .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
                .font(.system(size: width * 0.04, design: .rounded))
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .frame(width: width * 0.75, height: textHeight, alignment: .center)
                .padding(.leading, width * 0.125)
                .padding(.trailing, width * 0.125)
                .offset(y: -25)
        }
    }
}
