//
//  AchivementsTableView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 29/03/2021.
//

import SwiftUI
import Firebase

struct AchivementsTableView: View {
    
    @EnvironmentObject var currentUser : CurrentUserViewModel
    @EnvironmentObject var achivementViewModel : AchivementViewModel
    @State var showingAchivementLogged : Bool = false
    @State var pressedState : Int = 0
    @State private var showingLogIn = false
    
    var boxWidth : CGFloat {
        return width * 0.8
    }
    var boxHeight : CGFloat {
        return height < 750 ? height * 0.2 : height * 0.15
    }
    var achivementWidth : CGFloat {
        return width * 0.2
    }
    var achivementPadding : CGFloat {
        return width * 0.025
    }
    var achivementLinePadding : CGFloat {
        return height * 0.05
    }
    let smallShadowRadius : CGFloat = 5
    let smallShadowDimensions : CGFloat = 2
    let cornerRadius : CGFloat = 20
    let shadowRadius : CGFloat = 10
    let shadowDimensions : CGFloat = 5
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack{
            Rectangle() //Achivements
                .fill(Color(ColorConfig().getDefaultBackColor()))
                .frame(width: boxWidth, height: boxHeight, alignment: .center)
                .cornerRadius(cornerRadius)
                .shadow(radius: shadowRadius, x: shadowDimensions, y: shadowDimensions)
            HStack{
                Image(achivementViewModel.achivementList[0].image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: achivementWidth, height: achivementWidth, alignment: .leading)
                    .padding(.leading, achivementPadding)
                    .padding(.trailing, achivementPadding)
                    .shadow(radius: smallShadowRadius, x: smallShadowDimensions, y: smallShadowDimensions)
                    .opacity(achivementViewModel.achivementList[0].isComplete ? 1 : 0.3)
                    .onTapGesture {
                        self.pressedState = 0
                        self.showingAchivementLogged = true
                    }
                Image(achivementViewModel.achivementList[1].image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: achivementWidth, height: achivementWidth, alignment: .leading)
                    .padding(.trailing, achivementPadding)
                    .shadow(radius: smallShadowRadius, x: smallShadowDimensions, y: smallShadowDimensions)
                    .opacity(achivementViewModel.achivementList[1].isComplete ? 1 : 0.3)
                    .onTapGesture {
                        self.pressedState = 1
                        self.showingAchivementLogged = true
                    }
                Image(achivementViewModel.achivementList[2].image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: achivementWidth, height: achivementWidth, alignment: .leading)
                    .padding(.trailing, achivementPadding)
                    .shadow(radius: smallShadowRadius, x: smallShadowDimensions, y: smallShadowDimensions)
                    .opacity(achivementViewModel.achivementList[2].isComplete ? 1 : 0.3)
                    .onTapGesture {
                        self.pressedState = 2
                        self.showingAchivementLogged = true
                    }
            }
        }
        .alert(isPresented: $showingAchivementLogged) {
                    Alert(title: Text(achivementViewModel.achivementList[pressedState].name), message: Text(achivementViewModel.achivementList[pressedState].description), dismissButton: .default(Text("Got it!")))
                }
        .sheet(isPresented: $showingLogIn) {
            LogInView().environmentObject(self.currentUser)
        }
    }
}
