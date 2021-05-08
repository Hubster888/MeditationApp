//
//  MenuButtonView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 08/04/2021.
//

import SwiftUI

struct MenuButtonView: View {
    
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var menuButtonX : CGFloat {
        return width * 1
    }
    var menuButtonY : CGFloat {
        return height * 0.95
    }
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color(ColorConfig().getDefaultMainColor()))
                .frame(width: homeViewModel.menuIsActive ? height * 1.9 : width * 0.1, height: homeViewModel.menuIsActive ? height * 1.9 :width * 0.1, alignment: .bottomTrailing)
                .scaleEffect(height < 750 ? 1.1 : 1)
            Circle()
                .fill(homeViewModel.menuIsActive ? Color(ColorConfig().getDefaultBackColor()) : Color(ColorConfig().getDefaultMainColor()))
                .frame(width: width * 0.4, height: width * 0.4, alignment: .bottomTrailing)
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.6)){
                        homeViewModel.menuIsActive.toggle()
                    }
                }
            Image(homeViewModel.menuIsActive ? "gear1" : "gear2")
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.25, height: width * 0.25, alignment: .bottomTrailing)
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.6)){
                        homeViewModel.menuIsActive.toggle()
                    }
                }
        }
    }
}

struct MenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MenuButtonView()
            .previewLayout(.sizeThatFits)
            .environmentObject(HomeViewModel())
    }
}
