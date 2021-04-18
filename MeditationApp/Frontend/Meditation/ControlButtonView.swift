//
//  ControlButtonView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 11/04/2021.
//

import SwiftUI

struct ControlButtonView: View {
    
    enum `Type`{
        case end
        case playPause
    }
    
    let type : Type
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    @EnvironmentObject var meditationViewModel : MeditationViewModel
    
    var body: some View {
            switch(type){
            case .playPause:
                HStack{
                    Image(systemName: meditationViewModel.timerIsRunning ? "pause" : "play")
                    Text(meditationViewModel.timerIsRunning ? "STOP" : "PLAY")
                        .bold()
                }
                .background(
                    Circle().fill(Color(ColorConfig().getPauseColor()))
                        .frame(width: 160, height: 160, alignment: .leading)
                        .blur(radius: 3)
                        .offset(x: meditationViewModel.timerIsRunning ? 0 : -160, y: -40)
                        .animation(.easeInOut(duration: 1), value: meditationViewModel.timerIsRunning)
                )
                .padding()
                .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
                .background(Color(ColorConfig().getStartColor()))
                .cornerRadius(25)
                .clipped()
                .shadow(radius: 20)
                .scaleEffect(1.3)
            case .end:
                Text("END")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
                    .background(
                        Rectangle().fill(Color(ColorConfig().getDefaultMainColor()))
                            .frame(width: 160, height: 50, alignment: .center)
                            .blur(radius: 3)
                            .cornerRadius(15)
                )
            }
    }
}
