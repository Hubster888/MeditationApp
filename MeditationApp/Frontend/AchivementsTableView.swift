//
//  AchivementsTableView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 29/03/2021.
//

import SwiftUI

struct AchivementsTableView: View {
    
    @EnvironmentObject var achivementViewModel : AchivementViewModel
    
    var boxWidth : CGFloat {
        return width * 0.8
    }
    var boxHeight : CGFloat {
        return height < 750 ? height * 0.35 : height * 0.3
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
            VStack{
                HStack{
                    Image(achivementViewModel.achivementList[0].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: achivementWidth, height: achivementWidth, alignment: .leading)
                        .padding(.leading, achivementPadding)
                        .padding(.trailing, achivementPadding)
                        .shadow(radius: smallShadowRadius, x: smallShadowDimensions, y: smallShadowDimensions)
                        .onTapGesture {
                            print(achivementViewModel.achivementList[0].name)
                        }
                    Image(achivementViewModel.achivementList[1].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: achivementWidth, height: achivementWidth, alignment: .leading)
                        .padding(.trailing, achivementPadding)
                        .shadow(radius: smallShadowRadius, x: smallShadowDimensions, y: smallShadowDimensions)
                    Image(achivementViewModel.achivementList[2].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: achivementWidth, height: achivementWidth, alignment: .leading)
                        .padding(.trailing, achivementPadding)
                        .shadow(radius: smallShadowRadius, x: smallShadowDimensions, y: smallShadowDimensions)
                }
                .padding(.bottom, achivementLinePadding)
                HStack{
                    Image(achivementViewModel.achivementList[3].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: achivementWidth, height: achivementWidth, alignment: .leading)
                        .padding(.leading, achivementPadding)
                        .padding(.trailing, achivementPadding)
                        .shadow(radius: smallShadowRadius, x: smallShadowDimensions, y: smallShadowDimensions)
                    Image(achivementViewModel.achivementList[4].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: achivementWidth, height: achivementWidth, alignment: .leading)
                        .padding(.trailing, achivementPadding)
                        .shadow(radius: smallShadowRadius, x: smallShadowDimensions, y: smallShadowDimensions)
                    Image(achivementViewModel.achivementList[5].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: achivementWidth, height: achivementWidth, alignment: .leading)
                        .padding(.trailing, achivementPadding)
                        .shadow(radius: smallShadowRadius, x: smallShadowDimensions, y: smallShadowDimensions)
                        .onTapGesture {
                            print(achivementViewModel.achivementList[5].name)
                        }
                }
            }
        }
    }
}
