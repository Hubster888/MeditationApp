//
//  MusicListView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 08/04/2021.
//

import SwiftUI

struct MusicListView: View {
    
    //MARK: Variable Declerations
    // Data varialbes
    @EnvironmentObject var musicViewModel : MusicViewModel
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    // View variables
    var listElmWidth : CGFloat {
        return width * 0.45
    }
    var listElmHeight : CGFloat {
        return height * 0.175
    }
    var elmPadding : CGFloat {
        return width * 0.09
    }
    var listHeight : CGFloat {
        return height * 0.11
    }
    var backHeight : CGFloat {
        return height * 0.3
    }
    var listOffset : CGFloat {
        return height * 0.04
    }
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    let shadowRadius : CGFloat = 25
    
    //MARK: Body
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(ColorConfig().getMusicListColor()))
                .frame(width: width, height: backHeight, alignment: .top)
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
                .shadow(radius: shadowRadius)
                .opacity(0.6)
            VStack{
                Spacer()
                HStack(alignment: .center, spacing: elmPadding) {
                    ForEach(musicViewModel.musicList, id: \.self){ elm in
                        ListElmView(elm: elm, isSelected: elm.name == musicViewModel.chosenMusic.name)
                            .onTapGesture {
                                withAnimation{
                                    musicViewModel.chosenMusic.name = elm.name
                                }
                            }
                    }
                }
                .modifier(ScrollingHStackModifier(items: musicViewModel.musicList.count, itemWidth: listElmWidth, itemSpacing: elmPadding))
                .padding(.top, height * 0.1)
                //.offset(y: listOffset)
                Spacer()
            }
            Rectangle()
                .fill(Color(ColorConfig().getDefaultBackColor()).opacity(homeViewModel.menuIsActive ? 1 : 0))
                .frame(width: width, height: backHeight, alignment: .top)
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MusicListView_Previews: PreviewProvider {
    static var previews: some View {
        MusicListView()
            .environmentObject(MusicViewModel())
            .environmentObject(HomeViewModel())
            .previewLayout(.sizeThatFits)
    }
}
