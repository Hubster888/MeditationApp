//
//  EndView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 14/04/2021.
//

import SwiftUI

struct EndView: View {
    
    @EnvironmentObject var currentUser : CurrentUserViewModel
    @Environment(\.presentationMode) var presentationMode
    let circleShadow : CGFloat = 25
    let lineWidth : CGFloat = 5
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    let numOfPoints: Int
    @State var streakMultiplier = 1
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color(ColorConfig().getDefaultMainColor()))
                .frame(width: height, height: height, alignment: .center)
            VStack{
                Spacer()
                Text("Well Done!")
                    .font(.largeTitle)
                    .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
                    .bold()
                Text("Another session complete ")
                    .font(.title)
                    .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
                    .padding(.top, 30)
                Text("to add to your zen")
                    .font(.title)
                    .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
                    .padding(.top, 5)
                Text("+\(streakMultiplier * numOfPoints)")
                    .font(.largeTitle)
                    .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
                    .bold()
                    .padding(.top, 25)
                    .padding(.bottom, 30)
                AnimatedImageView(fileName: "meditationGIF")
                    .scaledToFit()
                    .mask(Circle())
                    .shadow(radius: circleShadow)
                    .overlay(Circle().stroke(Color(ColorConfig().getDefaultBackColor()), lineWidth: lineWidth).shadow(radius: circleShadow))
                    .frame(width: width * 0.7, height: width * 0.7, alignment: .center)
                Spacer()
                Button(action: {
                    currentUser.updateZenPoints(isAdd: true, numOfPoints: numOfPoints * streakMultiplier)
                    currentUser.updateTotalSessions()
                    presentationMode.wrappedValue.dismiss()
                }){
                    ZStack{
                        Rectangle()
                            .fill(Color(ColorConfig().getStartColor()))
                            .frame(width: width * 0.7, height: height * 0.05, alignment: .center)
                            .cornerRadius(20)
                        Text("FINISH")
                            .font(.title)
                            .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
                            .bold()
                    }.buttonStyle(ScaleAnimationButtonEffect())
                }
                Spacer()
            }
            .scaleEffect(height < 750 ? 0.9 : 1)
            .onAppear(){
                if(2 < currentUser.currentUser.currentStreak && currentUser.currentUser.currentStreak < 5){
                    streakMultiplier = 1
                }else if(4 < currentUser.currentUser.currentStreak && currentUser.currentUser.currentStreak < 15){
                    streakMultiplier = 2
                }else if(14 < currentUser.currentUser.currentStreak && currentUser.currentUser.currentStreak < 30){
                    streakMultiplier = 3
                }else if(29 < currentUser.currentUser.currentStreak && currentUser.currentUser.currentStreak < 100){
                    streakMultiplier = 4
                }else if(currentUser.currentUser.currentStreak >= 100){
                    streakMultiplier = 5
                }
            }
        }
    }
}

