//
//  ListElmView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 01/04/2021.
//

import SwiftUI
import Firebase

struct ListElmView: View {
    
    @EnvironmentObject var currentUser : CurrentUserViewModel
    let elm : Music
    var isSelected : Bool
    
    var listElmWidth : CGFloat {
        return width * 0.45
    }
    var listElmHeight : CGFloat {
        return height * 0.175
    }
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    var isLocked : Bool { return  elm.minZenPoints > currentUser.currentUser.currentZenPoints || (Auth.auth().currentUser == nil && elm.minZenPoints > 0)}
    
    var body: some View {
        ZStack{
            VStack{
                Image(elm.name)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 15)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(isSelected ? Color(ColorConfig().getDefaultMainColor()) : Color(ColorConfig().getDefaultBackColor()), lineWidth: 5).shadow(radius: -15))
                    .frame(width: listElmWidth - 5, height: listElmHeight - height * 0.02 - 5, alignment: .center)
                    .offset(y: -height * 0.02)
                    .opacity(isLocked ? 0.75 : 1)
                    .blur(radius: isLocked ? 2 : 0)
                    .overlay(
                        ZStack{
                            Image(systemName: "lock.fill")
                                .opacity(isLocked ? 1 : 0)
                                .scaleEffect(height < 800 ? 3 : 5)
                                .offset(y: -30)
                                .overlay(
                                    Text("\(elm.minZenPoints)")
                                            .foregroundColor(Color(ColorConfig().getLightTextColor()))
                                            .bold()
                                        .font(height < 800 ? .title3 : .title2)
                                        .frame(width: listElmWidth - 10, alignment: .center)
                                            .opacity(isLocked ? 1 : 0)
                                        .offset(y: height < 800 ? -20 : -15)
                                )
                            Text("Zen nedded!")
                                .bold()
                                .font(height < 800 ? .body : .title3)
                                .foregroundColor(Color(ColorConfig().getLightTextColor()))
                                .opacity(isLocked ? 1 : 0)
                                .offset(y: 20)
                        }
                    )
            }
        }
    }
}

struct ListElmView_Previews: PreviewProvider {
    static var previews: some View {
        ListElmView(elm: Music(name: "music1", minZenPoints: 0), isSelected: true)
            .previewLayout(.device)
    }
}
