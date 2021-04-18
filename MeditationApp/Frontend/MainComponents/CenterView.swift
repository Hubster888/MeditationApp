//
//  CenterView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 08/04/2021.
//

import SwiftUI

struct CenterView: View {
    
    //MARK: Variable data declerations
    // Data variables
    @State var showingSheet = false
    @EnvironmentObject var musicViewModel : MusicViewModel
    @EnvironmentObject var currentUser : CurrentUserViewModel
    // View variables
    var buttonWidth : CGFloat {
        return width * 0.65
    }
    var buttonHeight : CGFloat {
        return height * 0.1
    }
    var imageAnimationOffset : CGFloat {
        return width * 0.15
    }
    @State var isMoving : Bool = false
    @State private var horizontalTranslation: CGFloat = .zero
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    let circleShadow : CGFloat = 25
    let lineWidth : CGFloat = 5
    let cornerRadius : CGFloat = 40
    let buttonShadow : CGFloat = 10
    
    //MARK: Body
    var body: some View {
        VStack{
            Button(action: {showingSheet.toggle()}){
                ZStack{
                    Image(musicViewModel.chosenMusic.name)
                        .resizable()
                        .scaledToFit()
                        .offset(x: isMoving ? -imageAnimationOffset : imageAnimationOffset)
                        .animation(Animation.linear(duration: 8).repeatForever())
                        .onAppear(){
                            isMoving = true
                        }
                        .mask(Circle())
                        .shadow(radius: circleShadow)
                        .overlay(Circle().stroke(Color(ColorConfig().getDefaultBackColor()), lineWidth: lineWidth).shadow(radius: circleShadow))
                        .frame(width: width, height: width, alignment: .center)
                    Text("START")
                        .foregroundColor(Color(ColorConfig().getdarkTextColor()).opacity(0.5))
                        .font(.title)
                        .bold()
                        .scaleEffect(isMoving ? 1.2 : 0.85)
                        .animation(Animation.default.repeatForever().speed(0.3))
                }
            }
            .buttonStyle(ScaleAnimationButtonEffect())
            .shadow(radius: buttonShadow)
            .sheet(isPresented: $showingSheet) {
                MeditationView(musicName: musicViewModel.chosenMusic.name).environmentObject(self.currentUser)
            }
        }
    }
}

struct CenterView_Previews: PreviewProvider {
    static var previews: some View {
        CenterView()
            .environmentObject(MusicViewModel())
            .previewLayout(.sizeThatFits)
    }
}
