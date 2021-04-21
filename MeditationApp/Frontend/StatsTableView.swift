//
//  StatsTableView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 29/03/2021.
//

import SwiftUI

struct StatsTableView: View {
    
    @EnvironmentObject var currentUser : CurrentUserViewModel
    var columnHeight : CGFloat {
        return height * 0.25
    }
    var columnWidth : CGFloat {
        return (boxWidth - width * 0.1) / 3
    }
    var boxWidth : CGFloat {
        return width * 0.8
    }
    let cornerRadius : CGFloat = 20
    let shadowRadius : CGFloat = 10
    let shadowDimensions : CGFloat = 5
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    @State var streakMultiplier = 1
    
    var body: some View {
        ZStack{
            Rectangle() 
                .fill(Color(ColorConfig().getDefaultBackColor()))
                .frame(width: boxWidth, height: height < 750 ? height * 0.3 : columnHeight, alignment: .center)
                .cornerRadius(cornerRadius)
                .shadow(radius: shadowRadius, x: shadowDimensions, y: shadowDimensions)
            VStack{
                Spacer()
                ZStack{
                    Circle()
                        .fill(Color(ColorConfig().getDefaultMainColor()))
                        .shadow(radius: 5, x: 2, y: 2)
                    VStack{
                        Text(String(currentUser.currentUser.currentZenPoints))
                            .font(.title)
                            .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
                            .bold()
                        Text("ZEN")
                            .font(.title3)
                            .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
                    }
                }
                .frame(width: width * 0.25, height: width * 0.25, alignment: .center)
                .padding(.top, 10)
                Rectangle()
                    .fill(Color(ColorConfig().getDefaultMainColor()))
                    .frame(width: boxWidth, height: 7, alignment: .center)
                    .padding(.top, 10)
                HStack{
                    Spacer()
                    VStack{
                        Text("STREAK")
                            .font(.title3)
                        Text("\(currentUser.currentUser.currentStreak) Days - \(streakMultiplier)X")
                            .font(.title2)
                            .bold()
                    }
                    Spacer()
                    VStack{
                        Text("Total Sessions")
                            .font(.title3)
                        Text(String(currentUser.currentUser.totalSessions))
                            .font(.title2)
                            .bold()
                    }
                    Spacer()
                }
                .padding(.bottom, 15)
                .padding(.top, 15)
                Spacer()
            }
        }
        .frame(width: boxWidth, height: columnHeight, alignment: .center)
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

struct StatsTableView_Previews: PreviewProvider {
    static var previews: some View {
        StatsTableView()
            .previewLayout(.device)
    }
}
