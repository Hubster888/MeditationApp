//
//  ListElmView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 01/04/2021.
//

import SwiftUI

struct ListElmView: View {
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
    
    var body: some View {
        VStack{
            Image(elm.name)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 15)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(isSelected ? Color(ColorConfig().getDefaultMainColor()) : Color(ColorConfig().getDefaultBackColor()), lineWidth: 5).shadow(radius: -15))
                .frame(width: listElmWidth - 5, height: listElmHeight - height * 0.02 - 5, alignment: .center)
                .offset(y: -height * 0.02)
            Text("Music Name")
                .fontWeight(.bold)
                .font(.title2)
                .offset(y: -height * 0.01)
                .padding(.bottom, height * 0.01)
        }
    }
}

struct ListElmView_Previews: PreviewProvider {
    static var previews: some View {
        ListElmView(elm: Music(name: "music1"), isSelected: true)
            .previewLayout(.device)
    }
}
